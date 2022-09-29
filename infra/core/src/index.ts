import * as pulumi from "@pulumi/pulumi";
import * as gcp from "@pulumi/gcp";
import * as random from "@pulumi/random";
import * as path from "path";

// Check, and don't deploy on Friday
const dayOfWeek = new Date().getDay();
if (!pulumi.runtime.isDryRun() && dayOfWeek === 5) {
  throw new Error("Don't deploy on Friday!")
} else if (!pulumi.runtime.isDryRun()) {
  console.log("Not a Friday. Continuing...");
}


// This is the path to the other project relative to the CWD
const projectRoot = "../users-api";

const config = new pulumi.Config();

const region = config.get('region') || 'europe-west1';
const project = config.get('project') || 'gcp-certificates-363618';


const password = new random.RandomPassword('password', {
  length: 16
});

// const gcp = new gcp.secretmanager.Sec
// pulumi.output(gcp.secretmanager.getSecret({
//   secretId: "projects/50185966089/secrets/secret1",
//   // secretId: "secret1",
//   project,
// }));
const projects = gcp.organizations.getProject({
  projectId: project
});

const gcpConfig = new pulumi.Config("gcp")
// gcpConfig.requireSecret("")
const secret = config.requireSecret("key")
const secret1 = config.getSecret("key")

export const p1 = projects.then((s) => {
  return s.billingAccount;
});
export const config1 = gcpConfig;
export const s1 = secret;
export const s2 = secret1;


// const temp = new gcp.storage.Bucket('temp-bucket', {
//   name: `${project}-temp-bucket`,
//   location: region,
//   forceDestroy: true,
//   labels: {
//     type: 'temp',
//     team: 'util',
//   },
// });
