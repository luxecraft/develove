const functions = require("firebase-functions");
const client = require("./client");

module.exports = functions.https.onRequest((req, res) => {
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
