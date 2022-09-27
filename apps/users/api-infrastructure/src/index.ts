import * as pulumi from "@pulumi/pulumi";
import * as gcp from "@pulumi/gcp";
import * as path from "path";

// This is the path to the other project relative to the CWD
const projectRoot = "../users-api";

const config = new pulumi.Config();

const region = config.get('region') || 'europe-west1';
const project = config.get('project') || 'gcp-certificates-363618';

new gcp.storage.Bucket("yurikrupni-bucket", {
  location: region,
  project,
  forceDestroy: true,
  labels: {
    type: 'temp',
    team: 'util',
  },
})
