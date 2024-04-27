const express = require('express');
const debug = require('debug')('app:memberRouter');
const MemberController = require('../controllers/member.controller');
const authValidator = require('../middleware/validators/authValidator.middleware');

const memberRouter = express.Router();
const memberController = new MemberController();

memberRouter.get('/', authValidator.checkAuthenticatedEmployee, memberController.getMemberListView.bind(memberController));
memberRouter.get('/:memberId', authValidator.checkAuthenticated, memberController.getMemberDetailsView.bind(memberController));
memberRouter.get('/billing/payment', authValidator.checkAuthenticated, memberController.processPaymentView.bind(memberController));
memberRouter.post('/billing/payment', authValidator.checkAuthenticated, memberController.processPayment.bind(memberController));

module.exports = memberRouter;