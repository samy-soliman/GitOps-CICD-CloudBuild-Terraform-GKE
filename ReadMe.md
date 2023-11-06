# GitOps-style CI/CD pipeline on Google Cloud using CloudBuild

![SArchitecture](/Images/git-flow.PNG)
When you push a change to the app repository, the **Cloud Build** pipeline runs tests, builds a container image, and pushes it to **Artifact Registry**. After pushing the image, Cloud Build updates the Deployment manifest and pushes it to the env repository. This triggers another Cloud Build pipeline that applies the manifest to the **GKE** cluster and, if successful, stores the manifest in another branch of the env repository.

![CArchitecture](/Images/13.PNG)


## Explaining The Project Architecture:
1. The main of the project is to get our flask app to production.
2. We have 3 Folders **(App,IAC,Kube)**, each of which has its own repo.
   > you can find them in my account but i merged the three here for documenting.
   ![CArchitecture](/Images/4.PNG)
3. Each repo acts like **source of truth**, each has its own pipeline in cloudBuild.
4. Any change in IAC repo is resposible for triggering our **IAC pipeline** to create our infrastructure.
5. Our infrastructure is a simble **gke cluster** to deploy our app on.
6. The app repo contains the **app files and dockerfile** for the app, by commiting code to the app the trigger of the pipeline is fired.
7. The **App pipeline** steps: **test** the application, **build** a docker image for the app, **bushes** the image to **artifact registry** on gcp, **clones** the Kube repo to get the kubernetes deployment files, **editting** the Kubernetes files to point to the new docker image, **push** the new kubenetes files to the Kube repo on **branch candidate**, this push to the Kube repo **fires** the Third pipeline, The Kube Pipeline.
8. The **Kube pipeline** deploys the new Kubernetes files on candidate branch to GKE cluster, then copies the files from candidate branch to production branch to save the state of successful deployments in this branch to at as the source of truth and makes it easy to revert to previous deployments.


## How To Get It Working:
1. Sign in to your Google Cloud account
2. select or create a Google Cloud project
3. Make sure that billing is enabled for your Google Cloud project.
4. Enable the Cloud Build , kubernetes, artifactregistry and Secret Manager APIs.
5. Create a service account to run your cloudbuild pipelines with limited permisstions for security.
6. Create 3 repos one for the App another one for the IAC files and the last is for Kubernetes manifest
7. Add a your Github as a connection in cloudBuild and import the three repos.
8. create a trigger for each repo, specify the name of the script as **cloudbuild.yml** and the branch as your case.

<b>This is enough to get the project up, but you need to takecare of few things let me list them for You</b>

## Implementation Details:
1. To allow the App pipeline to push changes to the Kube repository, we first need to authenticate using our GitHub     account. This can be achieved by creating an SSH key and storing it securely in Google Secrets Manager. This key will allow Cloud Build permission to push commits to the repository.
![CArchitecture](/Images/3.PNG)
2. Add the public SSH key to your private repository's deploy keys.
![CArchitecture](/Images/6.PNG)

## Simple Overview
<b>lets see a simple run of the project exploring it ;D</b>

1. We start by creating our infrastructure, we can do this by making a commit to the IAC repo.
![CArchitecture](/Images/14.PNG)

2. inspect pipeline steps in cloudbuild.
![CArchitecture](/Images/7.PNG)

3. makking sure the cluster is created.
![CArchitecture](/Images/10.PNG)