'use strict';
import { Types } from '../config';
export const initialState = {
	Loan: null,
	IsBill: false, // 是否有历史账单
};
export function LoanReducer (state = initialState, action) {
	switch (action.type) {
		case Types.UPDATE_LOAN: {
			let loan = action.data.Ret === 200 ? action.data : null;
			return {
				...state,
				Loan: loan,
				IsBill: (action.data.IsBill !== undefined) ? action.data.IsBill : state.IsBill
			};
		}
		case Types.LOGOUT: {
			return {
				...state,
				IsBill: false,
				Loan: null
			};
		}
		default:
			return state;
	}
}