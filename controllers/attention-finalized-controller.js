'use strict';
let modelo = require('../models/attention-finalized-modell'),
    sess = null,
    AttentionFinalizedController = function () {};

AttentionFinalizedController.finalized = function( req, res ){
    sess = req.session;
    res.render('attention-finalized',{ usuario : sess.usuarioDatos } );
};

module.exports = AttentionFinalizedController;