let express = require('express'),
    router = express.Router(),
    authenticationController = require('../controllers/authenticacion-controller');


router
    .get('/', authenticationController.login)

    .post('/authentication', authenticationController.authentication)

    .get('/logout', authenticationController.logout);

module.exports = router;
