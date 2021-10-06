const functions = require("firebase-functions");
const client = require("./client");

module.exports = functions.https.onRequest((req, res) => {
  if (req.body.type === "DELETE") {
    return client
      .collections("posts")
      .documents(req.body.old_record.pid.toString())
      .delete()
      .then((collections) => {
        functions.logger.info(collections);
        res.send(collections);
        res.status(200);
      });
  } else {
    const record = req.body.record;
    record.id = record.pid.toString();
    return client
      .collections("posts")
      .documents()
      .upsert(record)
      .then((collections) => {
        functions.logger.info(collections);
        res.send(collections);
        res.status(200);
      });
  }
});
