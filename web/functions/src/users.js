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
