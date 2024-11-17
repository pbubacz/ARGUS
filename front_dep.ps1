cd frontend
tar -a -c -f ../deploy.zip *
cd ..
az webapp deploy --subscription $SubscriptionID  --resource-group $ResourceGroupName --name $WebAppName --src-path deploy.zip --type zip --async true
#rm deploy.zip