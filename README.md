# ARGUS Project Fork

This fork enables deployment of the ARGUS project with a front end on Azure using Web App. 
The original project is available [here](https://github.com/Azure-Samples/ARGUS). 
Feel free to reach out with any questions or suggestions.

# ARGUS: Automated Retrieval and GPT Understanding System
### 

> Argus Panoptes, in ancient Greek mythology, was a giant with a hundred eyes and a servant of the goddess Hera. His many eyes made him an excellent watchman, as some of his eyes would always remain open while the others slept, allowing him to be ever-vigilant.

## This solution demonstrates Azure Document Intelligence + GPT4 Vision

Classic OCR (Object Character Recognition) models lack reasoning ability based on context when extracting information from documents. In this project we demonstrate how to use a hybrid approach with OCR and LLM (multimodal Large Language Model) to get better results without any pre-training.

This solution uses Azure Document Intelligence combined with GPT4-Vision. Each of the tools have their strong points and the hybrid approach is better than any of them alone.

> Notes:
> - The Azure OpenAI model needs to be vision capable i.e. GPT-4T-0125, 0409 or Omni


## Solution Overview

- **Frontend**: A Streamlit Python web-app for user interaction. UNDER CONSTRUCTION
- **Backend**: An Azure Function for core logic, Cosmos DB for auditing, logging, and storing output schemas, Azure Document Intelligence, GPT-4 Vision and a Logic App for integrating with Outlook Inbox.
- **Demo**: Sample documents, system prompts, and output schemas.

![architecture](docs/ArchitectureOverview.png)

## Prerequisites
### Azure OpenAI Resource

Before deploying the solution, you need to create an OpenAI resource and deploy a model that is vision capable.

1. **Create an OpenAI Resource**:
   - Follow the instructions [here](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/how-to/create-resource) to create an OpenAI resource in Azure.

2. **Deploy a Vision-Capable Model**:
   - Ensure the deployed model supports vision, such as GPT-4T-0125, GPT-4T-0409 or GPT-4-Omni.


## Deployment

1. Open res_dep.ps1 and provide the following parameters:
   - $resourceGroupName: New resource group name
   - $subscriptionId: Your existing subscription ID

2. Open infra/main.bicep and provide the following parameters:
   - azureOpenaiEndpoint: Your existing Azure OpenAI endpoint
   - azureOpenaiKey: Your existing Azure OpenAI key
   - azureOpenaiModelDeploymentName: Your existing Azure OpenAI model deployment name (if changing the model)
   - If needed! Adjust the resource names to adhere to naming conventions.

3. Run res_dep.ps1.

4. Wait about 10 minutes for the Docker images to be pulled after deployment. Check progress in Function App > Deployment Center > Logs.

5. [Configure the web app to use Microsoft Entra sign-in](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-aad?tabs=workforce-configuration).

6. Deploy the web app:
   - Open front_dep.ps1 and provide the following parameters:
     - $resourceGroupName: New resource group name
     - $subscriptionId: Your existing subscription ID
     - $webAppName: New web app name

## How to Use

### Upload and Process Documents

1. **Upload PDF Files**:
   - Navigate to the `sa-uniqueID` storage account and the `datasets` container
   - Create a new folder called `default-dataset` and upload your PDF files.

2. **View Results**:
   - Processed results will be available in your Cosmos DB database under the `doc-extracts` collection and the `documents` container.


## Model Input Instructions

The input to the model consists of two main components: a `model prompt` and a `JSON template` with the schema of the data to be extracted.

### `Model Prompt`

The prompt is a textual instruction explaining what the model should do, including the type of data to extract and how to extract it. Here are a couple of example prompts:

1. **Default Prompt**:
Extract all data from the document. 

2. **Example Prompt**:
Extract all financial data, including transaction amounts, dates, and descriptions from the document. For date extraction use american formatting. 


### `JSON Template`

The JSON template defines the schema of the data to be extracted. This can be an empty JSON object `{}` if the model is supposed to create its own schema. Alternatively, it can be more specific to guide the model on what data to extract or for further processing in a structured database. Here are some examples:

1. Empty JSON Template (default):
```json
{}
```
2. Specific JSON Template Example:
```
{
    "transactionDate": "",
    "transactionAmount": "",
    "transactionDescription": ""
}
```
By providing a prompt and a JSON template, users can control the behavior of the model to extract specific data from their documents in a structured manner.

- JSON Schemas created using [JSON Schema Builder](https://bjdash.github.io/JSON-Schema-Builder/).



## Team behind ARGUS

- [Alberto Gallo](https://github.com/albertaga27)
- [Petteri Johansson](https://github.com/piizei)
- [Christin Pohl](https://github.com/pohlchri)
- [Konstantinos Mavrodis](https://github.com/kmavrodis_microsoft)


---

This README file provides an overview and quickstart guide for deploying and using Project ARGUS. For detailed instructions, consult the documentation and code comments in the respective files.
