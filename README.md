# Demo managed application for Azure

* `README.md` is this file
* `deploy-base.sh` deploys the storage account for all the zips
* `release-appdef-package.sh` deploys the zip that tells the managed app what to do
* `release-function-app-package.sh` deploys the zip for the Function App
  * Not implemented at this time
* `demoappdef/` deploys an app definition
  * Requires URI of app def package as input
* `demoappdef/package/` contains JSON for the app's portal UI and ARM for the managed resources
  * It needs to be zipped and pushed to blob storage, and the URI of that package given to `demoappdef/`
* `testapp/` deploys an instance of the managed application
  * Requires app def ARM ID as input
