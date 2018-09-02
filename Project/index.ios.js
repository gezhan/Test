/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */
import { AppRegistry } from 'react-native';
import Root from './app/Root';

global.__APP__ = true;
global.__ANDROID__ = false;
global.__IOS__ = true;

if (!__DEV__) {
	global.console = {
		info: () => { },
		log: () => { },
		warn: () => { },
		error: () => { },
	};
}

AppRegistry.registerComponent('MPR', () => Root);
