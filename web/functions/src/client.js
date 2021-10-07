const Typesense = require("typesense");
const functions = require("firebase-functions");

module.exports = new Typesense.Client({
  nodes: [
    {
      host: "develove.ts.luxecraft.org",
      port: "443",
      protocol: "https",
    },
  ],
  apiKey: functions.config().typesense.api_key,
  connectionTimeoutSeconds: 120,
  retryIntervalSeconds: 120,
});
