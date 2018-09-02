'use strict';
import Toast from 'react-native-root-toast';

export let toast;

export const toastShort = content => {
	if (toast !== undefined) {
		Toast.hide(toast);
	}
	toast = Toast.show(content.toString(), {
		duration: Toast.durations.SHORT,
		position: Toast.positions.CENTER,
		shadow: true,
		animation: true,
		hideOnPress: true,
		delay: 0
	});
};

export const toastLong = content => {
	if (toast !== undefined) {
		Toast.hide(toast);
	}
	toast = Toast.show(content.toString(), {
		duration: Toast.durations.LONG,
		position: Toast.positions.CENTER,
		shadow: true,
		animation: true,
		hideOnPress: true,
		delay: 0
	});
};
export const toastTopShort = content => {
	if (toast !== undefined) {
		Toast.hide(toast);
	}
	toast = Toast.show(content.toString(), {
		duration: Toast.durations.SHORT,
		position: Toast.positions.TOP,
		shadow: true,
		animation: true,
		hideOnPress: true,
		delay: 0
	});
};