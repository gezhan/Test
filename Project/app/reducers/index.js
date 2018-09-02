'use strict';
import { combineReducers } from 'redux';
import { BaseReducer } from './BaseReducer';
import { HomeReducer } from './HomeReducer'
import { AuthReducer } from './AuthReducer';
import { LoanReducer } from './LoanReducer'

const rootReducer = combineReducers({
	baseInfo: BaseReducer,
	homeData: HomeReducer,
	authInfo: AuthReducer,
	loanData: LoanReducer
});
export default rootReducer;