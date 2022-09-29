import { pulumiGcpPubsub } from "./pulumi-gcp-pubsub";

describe("pulumiGcpPubsub", () => {
  it("should work", () => {
    expect(pulumiGcpPubsub()).toEqual("pulumi-gcp-pubsub");
  });
});
