const typesense = require("typesense");
const functions = require("firebase-functions");

exports.users = functions.https.onRequest((req, res) => {
  const client = new typesense.Client({
    nodes: [
      {
        host: "develove.ts.luxecraft.org",
        port: "443",
        protocol: "https",
      },
    ],
    apiKey: functions.config().typesense.api_key,
    connectionTimeoutSeconds: 2,
  });

  return client
    .collections()
    .document()
    .create()
    .then((collections) => {
      functions.logger.info(collections);
      res.send(collections);
      res.status(200);
    });
});
