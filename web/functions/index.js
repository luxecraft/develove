const Typesense = require("typesense");
const functions = require("firebase-functions");

exports.helloWorld = functions.https.onRequest((req, res) => {
  const client = new Typesense.Client({
    nodes: [
      {
        host: "develove.ts.luxecraft.org",
        port: "443",
        protocol: "https",
      },
    ],
    apiKey: "TPBbQ8qrVfkokxdno0Xt8GakbmH26Wkcjy15VhMPnK3jlNR4",
    connectionTimeoutSeconds: 120,
    retryIntervalSeconds: 120,
  });

  if (req.body.type === "DELETE") {
    return client
      .collections("users")
      .documents(req.body.old_record.uid.toString())
      .delete()
      .then((collections) => {
        functions.logger.info(collections);
        res.send(collections);
        res.status(200);
      });
  } else {
    const record = req.body.record;
    record.id = record.uid.toString();
    return client
      .collections("users")
      .documents()
      .upsert(record)
      .then((collections) => {
        functions.logger.info(collections);
        res.send(collections);
        res.status(200);
      });
  }
});
