'use strict';
import {
	createStore,
	applyMiddleware
} from 'redux'
import rootReducer from '../reducers/index'
import thunkMiddleWare from 'redux-thunk';
import logger from 'redux-logger'
import {
	persistStore,
	autoRehydrate
} from 'redux-persist';
import {
	AsyncStorage
} from 'react-native';

let middlewares = [
	logger,
	thunkMiddleWare
];

let createAppStore = applyMiddleware(...middlewares)(createStore);

export default function configureStore (onComplete = () => {}) {
	const store = autoRehydrate()(createAppStore)(rootReducer);
	let opt = {
		storage: AsyncStorage,
		transform: [],
		//whitelist: ['userStore'],
	};
	persistStore(store, opt, onComplete);
	return store;
}