let express = require('express')
    , path = require('path')
    , favicon = require('serve-favicon')
    , logger = require('morgan')
    , cookieParser = require('cookie-parser')
    , bodyParser = require('body-parser')
    , session = require('express-session')
    , authentication = require('./routes/authentication-route')
    , panel = require('./routes/panel-route')
    , configuration = require('./routes/configuration-route')
    , search = require('./routes/search-route')
    , formAttention = require('./routes/form-attention-route')
    , finalized = require('./routes/attention-finalized-route')
    , consultation = require('./routes/consultation-route')
    , profile = require('./routes/profile-route')
    , app = express();

// view engine setup
app
    .set('views', path.join(__dirname, 'views'))
    .engine("html", require("ejs").renderFile)
    .set('view engine', 'html');


// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app
    .use(logger('dev'))
    .use(bodyParser.json())
    .use(bodyParser.urlencoded({ extended: false }))
    .use(cookieParser())
    .use(express.static(path.join(__dirname, 'public')))
    .use(session({
        secret: '4587controlMedico14685',
        cookie: { maxAge: 2628000000 },
        resave: false,
        saveUninitialized: true,
    }));

app
    .use('/', authentication)
    .use('/panel', panel)
    .use('/configuration', configuration)
    .use('/search', search)
    .use('/formAttention', formAttention)
    .use('/finalized', finalized)
    .use('/consultation', consultation)
    .use('/profile', profile);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  let err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
