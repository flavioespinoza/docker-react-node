const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const session = require('express-session');
const morgan = require('morgan');
const pino = require('pino')();
const log = require('ololog')
const MongoStore = require('connect-mongo')(session);

const Comment = require('./model/comments');
const app = express();
const router = express.Router();

pino.debug('Starting the MERN example');

let port = 5000;
let mongoURL = process.env.MONGO_URL || 'localhost';
let mongoUser = process.env.MONGO_USER || '';
let mongoPass = process.env.MONGO_PASSWORD || '';
let mongoDBName = process.env.MONGO_DB_NAME || 'exemplar';
let staticDir = process.env.STATIC_DIR || 'build';



// connect to the MongoDB
// let mongoConnect = `mongodb://${mongoUser}:${mongoPass}@${mongoURL}/${mongoDBName}`;
const mongoConnect = 'mongodb://slammin_hottie:ReverseCowg1rl@ds249428.mlab.com:49428/exemplar'
pino.info(`Connect to ${mongoConnect}`);

mongoose.Promise = global.Promise;
mongoose.connect(mongoConnect)
  .catch((err) => {
    if (err) pino.error(err);
  });

let db = mongoose.connection;
db.on('error', (error) => {
  pino.error(error);
});

// set up other middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

let sess = {
  store: new MongoStore({ mongooseConnection: mongoose.connection }),
  name: 'mern example',
  secret: 'keyboard cat',
  resave: false,
  saveUnitialized: true,
  cookie: {}
};

// production only middleware
if (process.env.NODE_ENV == 'production') {
  pino.info('Using production mode');
  let compression = require('compression');
  app.use(compression());

  app.use(express.static(staticDir));

  app.set('trust proxy', 1); // trust the first proxy
  // sess.cookie.secure = true;

  app.use(morgan('combined'));
}

app.use(session(sess));


router.get('/', function (req, res) {
  res.json({ message: 'API initialized' })
})

router.route('/comments')
  .get(function (req, res) {
    Comment.find(function (err, comments) {
      if (err)
        res.send(err);
      res.json(comments);
    });
  })
  .post(function (req, res) {

    let text = req.body.text;
    let author = req.session.author;
    let twitter = req.session.twitter;
    let imageURL = req.session.imageURL;

    if (!text || !author || !twitter || !imageURL) {
      res.json({ message: 'Not signed in' });
      return
    }

    let comment = new Comment(
      {
        author: author,
        text: text,
        twitter: twitter,
        imageURL: imageURL
      }
    );

    comment.save(function (err) {
      if (err)
        res.send(err);
      res.json({ message: 'Comment successfully added!' })
    });
  });

router.route('/comments/:comment_id')
  .put(function (req, res) {

  })
  .delete(function (req, res) {
    Comment.remove({ _id: req.params.comment_id }, function (err, comment) {
      if (err)
        res.send(err);
      res.json({ message: 'Comment has been deleted' })
    });
  });

router.post('/comments/logout', (req, res) => {

  req.session.destroy();
  pino.info('Logged out');

  res.json({ message: 'Successfully logged out' });
});

router.post('/comments/login', (req, res) => {
  let author = req.body.author;
  let twitter = req.body.twitter;
  let imageURL = req.body.imageURL;

  pino.info(`Received sign in request from ${author}, ${twitter}, ${imageURL}`);

  req.session.author = author;
  req.session.twitter = twitter;
  req.session.imageURL = imageURL;

  res.json({ message: 'Successfully logged in' });

});

router.get('/comments/session', (req, res) => {
  res.json({
    author: req.session.author,
    twitter: req.session.twitter,
    imageURL: req.session.imageURL
  });
});

app.use('/api', router);

app.get('/health', (req, res) => {
  res.json({
    state: "UP"
  })
});

app.listen(port, function () {
	// pino.info(`api running on port ${port}`);
	log.lightMagenta(`Server running on port ${port}`)
});


