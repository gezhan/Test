'use strict'
import {
	NativeModules
} from 'react-native'
const RNDeviceInfo = NativeModules.RNDeviceInfo
export default class DeviceInfo {
	static getUniqueID () {
		return RNDeviceInfo.uniqueId
	}

	static getIdfa () {
		return RNDeviceInfo.idfa
	}

	static getIdfv () {
		return RNDeviceInfo.idfv
	}

	static getChannel () {
		return RNDeviceInfo.channel
	}

	static getImei () {
		return RNDeviceInfo.imei
	}

	static getInstanceID () {
		return RNDeviceInfo.instanceId
	}

	static getDeviceId () {
		return RNDeviceInfo.deviceId
	}

	static getManufacturer () {
		return RNDeviceInfo.systemManufacturer
	}

	static getModel () {
		return RNDeviceInfo.model
	}

	static getBrand () {
		return RNDeviceInfo.brand
	}

	static getSystemName () {
		return RNDeviceInfo.systemName
	}

	static getSystemVersion () {
		return RNDeviceInfo.systemVersion
	}

	static getBundleId () {
		return RNDeviceInfo.bundleId
	}

	static getBuildNumber () {
		return RNDeviceInfo.buildNumber
	}

	static getVersion () {
		return RNDeviceInfo.appVersion
	}

	static getReadableVersion () {
		return RNDeviceInfo.appVersion + '.' + RNDeviceInfo.buildNumber
	}

	static getDeviceName () {
		return RNDeviceInfo.deviceName
	}

	static getUserAgent () {
		return RNDeviceInfo.userAgent
	}

	static getDeviceLocale () {
		return RNDeviceInfo.deviceLocale
	}

	static getDeviceCountry () {
		return RNDeviceInfo.deviceCountry
	}

	static getTimezone () {
		return RNDeviceInfo.timezone
	}

	static isEmulator () {
		return RNDeviceInfo.isEmulator
	}

	static isTablet () {
		return RNDeviceInfo.isTablet
	}

	static isPinOrFingerprintSet () {
		return RNDeviceInfo.isPinOrFingerprintSet
	}
}