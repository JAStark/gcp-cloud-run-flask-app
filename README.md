# gcp-cloud-run-flask-app
Following blog post https://medium.com/fullstackai/how-to-deploy-a-simple-flask-app-on-cloud-run-with-cloud-endpoint-e10088170eb7 by Takashi Nakamura to deploy a python Flask app with Endpoint.

Incorporating learnings from Google tutorial on [managing infrastructure as code](https://cloud.google.com/solutions/managing-infrastructure-as-code) to use Cloud Build and Terraform.


## Flow of logic:
1. pushing a feature branch to GitHub triggers the following:
  - root directory `cloudbuild.yaml` Build
  <!-- - flask app directory `Dockerfile` build  -->

2. Terraform builds a plan which includes the plan to create the Cloud Build Trigger
3. We MERGE TO DEV
4. TF rebuilds the plan and then applies the plan
4. The Cloud Build trigger is created in DEV, and the Dockerfile built and the image placed in Artifact Registry
4. Cloud Run is launched via the Docker image created by Cloud Build
5. _We make changes to a flask file in a new branch, and push to GitHub
6.
