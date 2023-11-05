When you push a change to the app repository, the Cloud Build pipeline runs tests, builds a container image, and pushes it to Artifact Registry. After pushing the image, Cloud Build updates the Deployment manifest and pushes it to the env repository. This triggers another Cloud Build pipeline that applies the manifest to the GKE cluster and, if successful, stores the manifest in another branch of the env repository.

We keep the app and env repositories separate because they have different lifecycles and uses. The main users of the app repository are actual humans and this repository is dedicated to a specific application. The main users of the env repository are automated systems (such as Cloud Build), and this repository might be shared by several applications. The env repository can have several branches that each map to a specific environment (you only use production in this tutorial) and reference a specific container image, whereas the app repository does not.

When you finish this tutorial, you have a system where you can easily:
1-Distinguish between failed and successful deployments by looking at the Cloud Build history,
2-Access the manifest currently used by looking at the production branch of the env repository,
3-Rollback to any previous version by re-executing the corresponding Cloud Build build.


Before you begin:
1- Sign in to your Google Cloud account
2- select or create a Google Cloud project
3- Make sure that billing is enabled for your Google Cloud project.
4- Enable the Cloud Build , artifactregistry and Secret Manager APIs.
5- Install the Google Cloud CLI.
6- To initialize the gcloud CLI, run the following command: gcloud init

Create a SSH key:
1- Open a terminal window.
2- Create a new GitHub SSH key, where github-email is your GitHub email address:
ssh-keygen -t rsa -b 4096 -N '' -f id_github -C github-email

Store the private SSH key in Secret Manager:
1- Go to the Secret Manager page in the Google Cloud console:
2- On the Secret Manager page, click Create Secret.
3- On the Create secret page, under Name, enter secret-name.
4- In the Secret value field, click Upload and upload your id_github file.
5- Leave the Regions section unchanged.
6- Click the Create secret button.

Add the public SSH key to your private repository's deploy keys:
1- add the public key as deploy-key in your repo
2- Select Allow write access if you want this key to have write access to the repository. A deploy key with write access lets a deployment push to the repository

Grant permissions
1- You need to grant the Cloud Build service account permission to access Secret Manager during the build.
2- Open the IAM page in the Google Cloud console:
3- Select your project and click Open.
4- Above the permissions table, select the Include Google-provided role grants checkbox.
You'll see that more rows appear in the permissions table.
5- In the permissions table, locate the email ending with @cloudbuild.gserviceaccount.com, and click on the pencil icon.
6- Add Secret Manager Secret Accessor role.

Add the public SSH key to known hosts
1- For Cloud Build to connect to GitHub, you must add the public SSH key to the known_hosts file in Cloud Build's build environment. You can do this by adding the key to a temporary known_hosts.github file, and then copying the contents of known_hosts.github to the known_hosts file in Cloud Build's build environment.
2- ssh-keyscan -t rsa github.com > known_hosts.github
3- when you configure the build, you'll add instructions in the Cloud Build config file to copy the contents of known_hosts.github to the known_hosts file in Cloud Build's build environment.
