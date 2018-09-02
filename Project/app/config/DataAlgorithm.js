'use strict';
//数据传输加密Key
const key = 'h*.d;cy7x_12dkx?#j39fdl!';

export default class DataAlgorithm {
	//3DES加密，CBC/PKCS5Padding
	static Des3Encrypt (input) {
		let genKey = genkey(key, 0, 24);
		return base64encode(des(genKey.key, input, 1, 1, key.substr(0, 8), 1));
	}

	//3DES解密，CBC/PKCS5Padding
	static Des3Decrypt (input) {
		let genKey = genkey(key, 0, 24);
		return des(genKey.key, base64decode(input), 0, 1, key.substr(0, 8), 1);
	}

	//md5
	static Md5Encrypt (input) {
		return md5(String(input));
	}

	static getKey () {
		return key;
	}
}


function des (key, message, encrypt, mode, iv, padding) {
	if (encrypt) //如果是加密的话，首先转换编码
		message = unescape(encodeURIComponent(message));
	//declaring this locally speeds things up a bit
	var spfunction1 = new Array(0x1010400, 0, 0x10000, 0x1010404, 0x1010004, 0x10404, 0x4, 0x10000, 0x400, 0x1010400, 0x1010404, 0x400, 0x1000404, 0x1010004, 0x1000000, 0x4, 0x404, 0x1000400, 0x1000400, 0x10400, 0x10400, 0x1010000, 0x1010000, 0x1000404, 0x10004, 0x1000004, 0x1000004, 0x10004, 0, 0x404, 0x10404, 0x1000000, 0x10000, 0x1010404, 0x4, 0x1010000, 0x1010400, 0x1000000, 0x1000000, 0x400, 0x1010004, 0x10000, 0x10400, 0x1000004, 0x400, 0x4, 0x1000404, 0x10404, 0x1010404, 0x10004, 0x1010000, 0x1000404, 0x1000004, 0x404, 0x10404, 0x1010400, 0x404, 0x1000400, 0x1000400, 0, 0x10004, 0x10400, 0, 0x1010004);
	var spfunction2 = new Array(-0x7fef7fe0, -0x7fff8000, 0x8000, 0x108020, 0x100000, 0x20, -0x7fefffe0, -0x7fff7fe0, -0x7fffffe0, -0x7fef7fe0, -0x7fef8000, -0x80000000, -0x7fff8000, 0x100000, 0x20, -0x7fefffe0, 0x108000, 0x100020, -0x7fff7fe0, 0, -0x80000000, 0x8000, 0x108020, -0x7ff00000, 0x100020, -0x7fffffe0, 0, 0x108000, 0x8020, -0x7fef8000, -0x7ff00000, 0x8020, 0, 0x108020, -0x7fefffe0, 0x100000, -0x7fff7fe0, -0x7ff00000, -0x7fef8000, 0x8000, -0x7ff00000, -0x7fff8000, 0x20, -0x7fef7fe0, 0x108020, 0x20, 0x8000, -0x80000000, 0x8020, -0x7fef8000, 0x100000, -0x7fffffe0, 0x100020, -0x7fff7fe0, -0x7fffffe0, 0x100020, 0x108000, 0, -0x7fff8000, 0x8020, -0x80000000, -0x7fefffe0, -0x7fef7fe0, 0x108000);
	var spfunction3 = new Array(0x208, 0x8020200, 0, 0x8020008, 0x8000200, 0, 0x20208, 0x8000200, 0x20008, 0x8000008, 0x8000008, 0x20000, 0x8020208, 0x20008, 0x8020000, 0x208, 0x8000000, 0x8, 0x8020200, 0x200, 0x20200, 0x8020000, 0x8020008, 0x20208, 0x8000208, 0x20200, 0x20000, 0x8000208, 0x8, 0x8020208, 0x200, 0x8000000, 0x8020200, 0x8000000, 0x20008, 0x208, 0x20000, 0x8020200, 0x8000200, 0, 0x200, 0x20008, 0x8020208, 0x8000200, 0x8000008, 0x200, 0, 0x8020008, 0x8000208, 0x20000, 0x8000000, 0x8020208, 0x8, 0x20208, 0x20200, 0x8000008, 0x8020000, 0x8000208, 0x208, 0x8020000, 0x20208, 0x8, 0x8020008, 0x20200);
	var spfunction4 = new Array(0x802001, 0x2081, 0x2081, 0x80, 0x802080, 0x800081, 0x800001, 0x2001, 0, 0x802000, 0x802000, 0x802081, 0x81, 0, 0x800080, 0x800001, 0x1, 0x2000, 0x800000, 0x802001, 0x80, 0x800000, 0x2001, 0x2080, 0x800081, 0x1, 0x2080, 0x800080, 0x2000, 0x802080, 0x802081, 0x81, 0x800080, 0x800001, 0x802000, 0x802081, 0x81, 0, 0, 0x802000, 0x2080, 0x800080, 0x800081, 0x1, 0x802001, 0x2081, 0x2081, 0x80, 0x802081, 0x81, 0x1, 0x2000, 0x800001, 0x2001, 0x802080, 0x800081, 0x2001, 0x2080, 0x800000, 0x802001, 0x80, 0x800000, 0x2000, 0x802080);
	var spfunction5 = new Array(0x100, 0x2080100, 0x2080000, 0x42000100, 0x80000, 0x100, 0x40000000, 0x2080000, 0x40080100, 0x80000, 0x2000100, 0x40080100, 0x42000100, 0x42080000, 0x80100, 0x40000000, 0x2000000, 0x40080000, 0x40080000, 0, 0x40000100, 0x42080100, 0x42080100, 0x2000100, 0x42080000, 0x40000100, 0, 0x42000000, 0x2080100, 0x2000000, 0x42000000, 0x80100, 0x80000, 0x42000100, 0x100, 0x2000000, 0x40000000, 0x2080000, 0x42000100, 0x40080100, 0x2000100, 0x40000000, 0x42080000, 0x2080100, 0x40080100, 0x100, 0x2000000, 0x42080000, 0x42080100, 0x80100, 0x42000000, 0x42080100, 0x2080000, 0, 0x40080000, 0x42000000, 0x80100, 0x2000100, 0x40000100, 0x80000, 0, 0x40080000, 0x2080100, 0x40000100);
	var spfunction6 = new Array(0x20000010, 0x20400000, 0x4000, 0x20404010, 0x20400000, 0x10, 0x20404010, 0x400000, 0x20004000, 0x404010, 0x400000, 0x20000010, 0x400010, 0x20004000, 0x20000000, 0x4010, 0, 0x400010, 0x20004010, 0x4000, 0x404000, 0x20004010, 0x10, 0x20400010, 0x20400010, 0, 0x404010, 0x20404000, 0x4010, 0x404000, 0x20404000, 0x20000000, 0x20004000, 0x10, 0x20400010, 0x404000, 0x20404010, 0x400000, 0x4010, 0x20000010, 0x400000, 0x20004000, 0x20000000, 0x4010, 0x20000010, 0x20404010, 0x404000, 0x20400000, 0x404010, 0x20404000, 0, 0x20400010, 0x10, 0x4000, 0x20400000, 0x404010, 0x4000, 0x400010, 0x20004010, 0, 0x20404000, 0x20000000, 0x400010, 0x20004010);
	var spfunction7 = new Array(0x200000, 0x4200002, 0x4000802, 0, 0x800, 0x4000802, 0x200802, 0x4200800, 0x4200802, 0x200000, 0, 0x4000002, 0x2, 0x4000000, 0x4200002, 0x802, 0x4000800, 0x200802, 0x200002, 0x4000800, 0x4000002, 0x4200000, 0x4200800, 0x200002, 0x4200000, 0x800, 0x802, 0x4200802, 0x200800, 0x2, 0x4000000, 0x200800, 0x4000000, 0x200800, 0x200000, 0x4000802, 0x4000802, 0x4200002, 0x4200002, 0x2, 0x200002, 0x4000000, 0x4000800, 0x200000, 0x4200800, 0x802, 0x200802, 0x4200800, 0x802, 0x4000002, 0x4200802, 0x4200000, 0x200800, 0, 0x2, 0x4200802, 0, 0x200802, 0x4200000, 0x800, 0x4000002, 0x4000800, 0x800, 0x200002);
	var spfunction8 = new Array(0x10001040, 0x1000, 0x40000, 0x10041040, 0x10000000, 0x10001040, 0x40, 0x10000000, 0x40040, 0x10040000, 0x10041040, 0x41000, 0x10041000, 0x41040, 0x1000, 0x40, 0x10040000, 0x10000040, 0x10001000, 0x1040, 0x41000, 0x40040, 0x10040040, 0x10041000, 0x1040, 0, 0, 0x10040040, 0x10000040, 0x10001000, 0x41040, 0x40000, 0x41040, 0x40000, 0x10041000, 0x1000, 0x40, 0x10040040, 0x1000, 0x41040, 0x10001000, 0x40, 0x10000040, 0x10040000, 0x10040040, 0x10000000, 0x40000, 0x10001040, 0, 0x10041040, 0x40040, 0x10000040, 0x10040000, 0x10001000, 0x10001040, 0, 0x10041040, 0x41000, 0x41000, 0x1040, 0x1040, 0x40040, 0x10000000, 0x10041000);

	//create the 16 or 48 subkeys we will need
	var keys = des_createKeys(key);
	var m = 0, i, j, temp, temp2, right1, right2, left, right, looping;
	var cbcleft, cbcleft2, cbcright, cbcright2
	var endloop, loopinc;
	var len = message.length;
	var chunk = 0;
	//set up the loops for single and triple des
	var iterations = keys.length == 32 ? 3 : 9; //single or triple des
	if (iterations == 3) {looping = encrypt ? new Array(0, 32, 2) : new Array(30, -2, -2);}
	else {looping = encrypt ? new Array(0, 32, 2, 62, 30, -2, 64, 96, 2) : new Array(94, 62, -2, 32, 64, 2, 30, -2, -2);}

	//pad the message depending on the padding parameter
	if (padding == 2) message += '        '; //pad the message with spaces
	else if (padding == 1) {
		if (encrypt) {
			temp = 8 - (len % 8);
			message += String.fromCharCode(temp, temp, temp, temp, temp, temp, temp, temp);
			if (temp === 8) len += 8;
		}
	} //PKCS7 padding
	else if (!padding) message += '\0\0\0\0\0\0\0\0'; //pad the message out with null bytes

	//store the result here
	var result = '';
	var tempresult = '';

	if (mode == 1) { //CBC mode
		cbcleft = (iv.charCodeAt(m++) << 24) | (iv.charCodeAt(m++) << 16) | (iv.charCodeAt(m++) << 8) | iv.charCodeAt(m++);
		cbcright = (iv.charCodeAt(m++) << 24) | (iv.charCodeAt(m++) << 16) | (iv.charCodeAt(m++) << 8) | iv.charCodeAt(m++);
		m = 0;
	}

	//loop through each 64 bit chunk of the message
	while (m < len) {
		left = (message.charCodeAt(m++) << 24) | (message.charCodeAt(m++) << 16) | (message.charCodeAt(m++) << 8) | message.charCodeAt(m++);
		right = (message.charCodeAt(m++) << 24) | (message.charCodeAt(m++) << 16) | (message.charCodeAt(m++) << 8) | message.charCodeAt(m++);

		//for Cipher Block Chaining mode, xor the message with the previous result
		if (mode == 1) {
			if (encrypt) {
				left ^= cbcleft;
				right ^= cbcright;
			} else {
				cbcleft2 = cbcleft;
				cbcright2 = cbcright;
				cbcleft = left;
				cbcright = right;
			}
		}

		//first each 64 but chunk of the message must be permuted according to IP
		temp = ((left >>> 4) ^ right) & 0x0f0f0f0f;
		right ^= temp;
		left ^= (temp << 4);
		temp = ((left >>> 16) ^ right) & 0x0000ffff;
		right ^= temp;
		left ^= (temp << 16);
		temp = ((right >>> 2) ^ left) & 0x33333333;
		left ^= temp;
		right ^= (temp << 2);
		temp = ((right >>> 8) ^ left) & 0x00ff00ff;
		left ^= temp;
		right ^= (temp << 8);
		temp = ((left >>> 1) ^ right) & 0x55555555;
		right ^= temp;
		left ^= (temp << 1);

		left = ((left << 1) | (left >>> 31));
		right = ((right << 1) | (right >>> 31));

		//do this either 1 or 3 times for each chunk of the message
		for (j = 0; j < iterations; j += 3) {
			endloop = looping[j + 1];
			loopinc = looping[j + 2];
			//now go through and perform the encryption or decryption
			for (i = looping[j]; i != endloop; i += loopinc) { //for efficiency
				right1 = right ^ keys[i];
				right2 = ((right >>> 4) | (right << 28)) ^ keys[i + 1];
				//the result is attained by passing these bytes through the S selection functions
				temp = left;
				left = right;
				right = temp ^ (spfunction2[(right1 >>> 24) & 0x3f] | spfunction4[(right1 >>> 16) & 0x3f]
					| spfunction6[(right1 >>> 8) & 0x3f] | spfunction8[right1 & 0x3f]
					| spfunction1[(right2 >>> 24) & 0x3f] | spfunction3[(right2 >>> 16) & 0x3f]
					| spfunction5[(right2 >>> 8) & 0x3f] | spfunction7[right2 & 0x3f]);
			}
			temp = left;
			left = right;
			right = temp; //unreverse left and right
		} //for either 1 or 3 iterations

		//move then each one bit to the right
		left = ((left >>> 1) | (left << 31));
		right = ((right >>> 1) | (right << 31));

		//now perform IP-1, which is IP in the opposite direction
		temp = ((left >>> 1) ^ right) & 0x55555555;
		right ^= temp;
		left ^= (temp << 1);
		temp = ((right >>> 8) ^ left) & 0x00ff00ff;
		left ^= temp;
		right ^= (temp << 8);
		temp = ((right >>> 2) ^ left) & 0x33333333;
		left ^= temp;
		right ^= (temp << 2);
		temp = ((left >>> 16) ^ right) & 0x0000ffff;
		right ^= temp;
		left ^= (temp << 16);
		temp = ((left >>> 4) ^ right) & 0x0f0f0f0f;
		right ^= temp;
		left ^= (temp << 4);

		//for Cipher Block Chaining mode, xor the message with the previous result
		if (mode == 1) {
			if (encrypt) {
				cbcleft = left;
				cbcright = right;
			} else {
				left ^= cbcleft2;
				right ^= cbcright2;
			}
		}
		tempresult += String.fromCharCode((left >>> 24), ((left >>> 16) & 0xff), ((left >>> 8) & 0xff), (left & 0xff), (right >>> 24), ((right >>> 16) & 0xff), ((right >>> 8) & 0xff), (right & 0xff));

		chunk += 8;
		if (chunk == 512) {
			result += tempresult;
			tempresult = '';
			chunk = 0;
		}
	} //for every 8 characters, or 64 bits in the message

	//return the result as an array
	result += tempresult;
	result = result.replace(/\0*$/g, '');

	if (!encrypt) { //如果是解密的话，解密结束后对PKCS7 padding进行解码，并转换成utf-8编码
		if (padding === 1) { //PKCS7 padding解码
			var len = result.length, paddingChars = 0;
			len && (paddingChars = result.charCodeAt(len - 1));
			(paddingChars <= 8) && (result = result.substring(0, len - paddingChars));
		}
		//转换成UTF-8编码
		result = decodeURIComponent(escape(result));
	}

	return result;
} //end of des


//des_createKeys
//this takes as input a 64 bit key (even though only 56 bits are used)
//as an array of 2 integers, and returns 16 48 bit keys
function des_createKeys (key) {
	//declaring this locally speeds things up a bit
	var pc2bytes0 = new Array(0, 0x4, 0x20000000, 0x20000004, 0x10000, 0x10004, 0x20010000, 0x20010004, 0x200, 0x204, 0x20000200, 0x20000204, 0x10200, 0x10204, 0x20010200, 0x20010204);
	var pc2bytes1 = new Array(0, 0x1, 0x100000, 0x100001, 0x4000000, 0x4000001, 0x4100000, 0x4100001, 0x100, 0x101, 0x100100, 0x100101, 0x4000100, 0x4000101, 0x4100100, 0x4100101);
	var pc2bytes2 = new Array(0, 0x8, 0x800, 0x808, 0x1000000, 0x1000008, 0x1000800, 0x1000808, 0, 0x8, 0x800, 0x808, 0x1000000, 0x1000008, 0x1000800, 0x1000808);
	var pc2bytes3 = new Array(0, 0x200000, 0x8000000, 0x8200000, 0x2000, 0x202000, 0x8002000, 0x8202000, 0x20000, 0x220000, 0x8020000, 0x8220000, 0x22000, 0x222000, 0x8022000, 0x8222000);
	var pc2bytes4 = new Array(0, 0x40000, 0x10, 0x40010, 0, 0x40000, 0x10, 0x40010, 0x1000, 0x41000, 0x1010, 0x41010, 0x1000, 0x41000, 0x1010, 0x41010);
	var pc2bytes5 = new Array(0, 0x400, 0x20, 0x420, 0, 0x400, 0x20, 0x420, 0x2000000, 0x2000400, 0x2000020, 0x2000420, 0x2000000, 0x2000400, 0x2000020, 0x2000420);
	var pc2bytes6 = new Array(0, 0x10000000, 0x80000, 0x10080000, 0x2, 0x10000002, 0x80002, 0x10080002, 0, 0x10000000, 0x80000, 0x10080000, 0x2, 0x10000002, 0x80002, 0x10080002);
	var pc2bytes7 = new Array(0, 0x10000, 0x800, 0x10800, 0x20000000, 0x20010000, 0x20000800, 0x20010800, 0x20000, 0x30000, 0x20800, 0x30800, 0x20020000, 0x20030000, 0x20020800, 0x20030800);
	var pc2bytes8 = new Array(0, 0x40000, 0, 0x40000, 0x2, 0x40002, 0x2, 0x40002, 0x2000000, 0x2040000, 0x2000000, 0x2040000, 0x2000002, 0x2040002, 0x2000002, 0x2040002);
	var pc2bytes9 = new Array(0, 0x10000000, 0x8, 0x10000008, 0, 0x10000000, 0x8, 0x10000008, 0x400, 0x10000400, 0x408, 0x10000408, 0x400, 0x10000400, 0x408, 0x10000408);
	var pc2bytes10 = new Array(0, 0x20, 0, 0x20, 0x100000, 0x100020, 0x100000, 0x100020, 0x2000, 0x2020, 0x2000, 0x2020, 0x102000, 0x102020, 0x102000, 0x102020);
	var pc2bytes11 = new Array(0, 0x1000000, 0x200, 0x1000200, 0x200000, 0x1200000, 0x200200, 0x1200200, 0x4000000, 0x5000000, 0x4000200, 0x5000200, 0x4200000, 0x5200000, 0x4200200, 0x5200200);
	var pc2bytes12 = new Array(0, 0x1000, 0x8000000, 0x8001000, 0x80000, 0x81000, 0x8080000, 0x8081000, 0x10, 0x1010, 0x8000010, 0x8001010, 0x80010, 0x81010, 0x8080010, 0x8081010);
	var pc2bytes13 = new Array(0, 0x4, 0x100, 0x104, 0, 0x4, 0x100, 0x104, 0x1, 0x5, 0x101, 0x105, 0x1, 0x5, 0x101, 0x105);

	//how many iterations (1 for des, 3 for triple des)
	var iterations = key.length > 8 ? 3 : 1; //changed by Paul 16/6/2007 to use Triple DES for 9+ byte keys
	//stores the return keys
	var keys = new Array(32 * iterations);
	//now define the left shifts which need to be done
	var shifts = new Array(0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0);
	//other variables
	var lefttemp, righttemp, m = 0, n = 0, temp;

	for (var j = 0; j < iterations; j++) { //either 1 or 3 iterations
		var left = (key.charCodeAt(m++) << 24) | (key.charCodeAt(m++) << 16) | (key.charCodeAt(m++) << 8) | key.charCodeAt(m++);
		var right = (key.charCodeAt(m++) << 24) | (key.charCodeAt(m++) << 16) | (key.charCodeAt(m++) << 8) | key.charCodeAt(m++);

		temp = ((left >>> 4) ^ right) & 0x0f0f0f0f;
		right ^= temp;
		left ^= (temp << 4);
		temp = ((right >>> -16) ^ left) & 0x0000ffff;
		left ^= temp;
		right ^= (temp << -16);
		temp = ((left >>> 2) ^ right) & 0x33333333;
		right ^= temp;
		left ^= (temp << 2);
		temp = ((right >>> -16) ^ left) & 0x0000ffff;
		left ^= temp;
		right ^= (temp << -16);
		temp = ((left >>> 1) ^ right) & 0x55555555;
		right ^= temp;
		left ^= (temp << 1);
		temp = ((right >>> 8) ^ left) & 0x00ff00ff;
		left ^= temp;
		right ^= (temp << 8);
		temp = ((left >>> 1) ^ right) & 0x55555555;
		right ^= temp;
		left ^= (temp << 1);

		//the right side needs to be shifted and to get the last four bits of the left side
		temp = (left << 8) | ((right >>> 20) & 0x000000f0);
		//left needs to be put upside down
		left = (right << 24) | ((right << 8) & 0xff0000) | ((right >>> 8) & 0xff00) | ((right >>> 24) & 0xf0);
		right = temp;

		//now go through and perform these shifts on the left and right keys
		for (var i = 0; i < shifts.length; i++) {
			//shift the keys either one or two bits to the left
			if (shifts[i]) {
				left = (left << 2) | (left >>> 26);
				right = (right << 2) | (right >>> 26);
			}
			else {
				left = (left << 1) | (left >>> 27);
				right = (right << 1) | (right >>> 27);
			}
			left &= -0xf;
			right &= -0xf;

			//now apply PC-2, in such a way that E is easier when encrypting or decrypting
			//this conversion will look like PC-2 except only the last 6 bits of each byte are used
			//rather than 48 consecutive bits and the order of lines will be according to
			//how the S selection functions will be applied: S2, S4, S6, S8, S1, S3, S5, S7
			lefttemp = pc2bytes0[left >>> 28] | pc2bytes1[(left >>> 24) & 0xf]
				| pc2bytes2[(left >>> 20) & 0xf] | pc2bytes3[(left >>> 16) & 0xf]
				| pc2bytes4[(left >>> 12) & 0xf] | pc2bytes5[(left >>> 8) & 0xf]
				| pc2bytes6[(left >>> 4) & 0xf];
			righttemp = pc2bytes7[right >>> 28] | pc2bytes8[(right >>> 24) & 0xf]
				| pc2bytes9[(right >>> 20) & 0xf] | pc2bytes10[(right >>> 16) & 0xf]
				| pc2bytes11[(right >>> 12) & 0xf] | pc2bytes12[(right >>> 8) & 0xf]
				| pc2bytes13[(right >>> 4) & 0xf];
			temp = ((righttemp >>> 16) ^ lefttemp) & 0x0000ffff;
			keys[n++] = lefttemp ^ temp;
			keys[n++] = righttemp ^ (temp << 16);
		}
	} //for each iterations
	//return the keys we've created
	return keys;
} //end of des_createKeys
function genkey (key, start, end) {
	//8 byte / 64 bit Key (DES) or 192 bit Key
	return { key: pad(key.slice(start, end)), vector: 1 };
}
function pad (key) {
	for (var i = key.length; i < 24; i++) {
		key += '0';
	}
	return key;
}

var BASE64_MAPPING = [
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
	'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
	'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
	'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
	'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
	'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
	'w', 'x', 'y', 'z', '0', '1', '2', '3',
	'4', '5', '6', '7', '8', '9', '+', '/'
];

/**
 *ascii convert to binary
 */
var _toBinary = function (ascii) {
	var binary = new Array();
	while (ascii > 0) {
		var b = ascii % 2;
		ascii = Math.floor(ascii / 2);
		binary.push(b);
	}
	/*
	 var len = binary.length;
	 if(6-len > 0){
	 for(var i = 6-len ; i > 0 ; --i){
	 binary.push(0);
	 }
	 }*/
	binary.reverse();
	return binary;
};

/**
 *binary convert to decimal
 */
var _toDecimal = function (binary) {
	var dec = 0;
	var p = 0;
	for (var i = binary.length - 1; i >= 0; --i) {
		var b = binary[i];
		if (b == 1) {
			dec += Math.pow(2, p);
		}
		++p;
	}
	return dec;
};

/**
 *unicode convert to utf-8
 */
var _toUTF8Binary = function (c, binaryArray) {
	var mustLen = (8 - (c + 1)) + ((c - 1) * 6);
	var fatLen = binaryArray.length;
	var diff = mustLen - fatLen;
	while (--diff >= 0) {
		binaryArray.unshift(0);
	}
	var binary = [];
	var _c = c;
	while (--_c >= 0) {
		binary.push(1);
	}
	binary.push(0);
	var i = 0, len = 8 - (c + 1);
	for (; i < len; ++i) {
		binary.push(binaryArray[i]);
	}

	for (var j = 0; j < c - 1; ++j) {
		binary.push(1);
		binary.push(0);
		var sum = 6;
		while (--sum >= 0) {
			binary.push(binaryArray[i++]);
		}
	}
	return binary;
};

var BASE64 = {
	/**
	 *BASE64 Encode
	 */
	encoder: function (str) {
		var base64_Index = [];
		var binaryArray = [];
		for (var i = 0, len = str.length; i < len; ++i) {
			var unicode = str.charCodeAt(i);
			var _tmpBinary = _toBinary(unicode);
			if (unicode < 0x80) {
				var _tmpdiff = 8 - _tmpBinary.length;
				while (--_tmpdiff >= 0) {
					_tmpBinary.unshift(0);
				}
				binaryArray = binaryArray.concat(_tmpBinary);
			} else if (unicode >= 0x80 && unicode <= 0x7FF) {
				binaryArray = binaryArray.concat(_toUTF8Binary(2, _tmpBinary));
			} else if (unicode >= 0x800 && unicode <= 0xFFFF) {//UTF-8 3byte
				binaryArray = binaryArray.concat(_toUTF8Binary(3, _tmpBinary));
			} else if (unicode >= 0x10000 && unicode <= 0x1FFFFF) {//UTF-8 4byte
				binaryArray = binaryArray.concat(_toUTF8Binary(4, _tmpBinary));
			} else if (unicode >= 0x200000 && unicode <= 0x3FFFFFF) {//UTF-8 5byte
				binaryArray = binaryArray.concat(_toUTF8Binary(5, _tmpBinary));
			} else if (unicode >= 4000000 && unicode <= 0x7FFFFFFF) {//UTF-8 6byte
				binaryArray = binaryArray.concat(_toUTF8Binary(6, _tmpBinary));
			}
		}

		var extra_Zero_Count = 0;
		for (var i = 0, len = binaryArray.length; i < len; i += 6) {
			var diff = (i + 6) - len;
			if (diff == 2) {
				extra_Zero_Count = 2;
			} else if (diff == 4) {
				extra_Zero_Count = 4;
			}
			//if(extra_Zero_Count > 0){
			//  len += extra_Zero_Count+1;
			//}
			var _tmpExtra_Zero_Count = extra_Zero_Count;
			while (--_tmpExtra_Zero_Count >= 0) {
				binaryArray.push(0);
			}
			base64_Index.push(_toDecimal(binaryArray.slice(i, i + 6)));
		}

		var base64 = '';
		for (var i = 0, len = base64_Index.length; i < len; ++i) {
			base64 += BASE64_MAPPING[base64_Index[i]];
		}

		for (var i = 0, len = extra_Zero_Count / 2; i < len; ++i) {
			base64 += '=';
		}
		return base64;
	},
	/**
	 *BASE64  Decode for UTF-8
	 */
	decoder: function (_base64Str) {
		var _len = _base64Str.length;
		var extra_Zero_Count = 0;
		/**
		 *计算在进行BASE64编码的时候，补了几个0
		 */
		if (_base64Str.charAt(_len - 1) == '=') {
			//alert(_base64Str.charAt(_len-1));
			//alert(_base64Str.charAt(_len-2));
			if (_base64Str.charAt(_len - 2) == '=') {//两个等号说明补了4个0
				extra_Zero_Count = 4;
				_base64Str = _base64Str.substring(0, _len - 2);
			} else {//一个等号说明补了2个0
				extra_Zero_Count = 2;
				_base64Str = _base64Str.substring(0, _len - 1);
			}
		}

		var binaryArray = [];
		for (var i = 0, len = _base64Str.length; i < len; ++i) {
			var c = _base64Str.charAt(i);
			for (var j = 0, size = BASE64_MAPPING.length; j < size; ++j) {
				if (c == BASE64_MAPPING[j]) {
					var _tmp = _toBinary(j);
					/*不足6位的补0*/
					var _tmpLen = _tmp.length;
					if (6 - _tmpLen > 0) {
						for (var k = 6 - _tmpLen; k > 0; --k) {
							_tmp.unshift(0);
						}
					}
					binaryArray = binaryArray.concat(_tmp);
					break;
				}
			}
		}

		if (extra_Zero_Count > 0) {
			binaryArray = binaryArray.slice(0, binaryArray.length - extra_Zero_Count);
		}

		var unicode = [];
		var unicodeBinary = [];
		for (var i = 0, len = binaryArray.length; i < len;) {
			if (binaryArray[i] == 0) {
				unicode = unicode.concat(_toDecimal(binaryArray.slice(i, i + 8)));
				i += 8;
			} else {
				var sum = 0;
				while (i < len) {
					if (binaryArray[i] == 1) {
						++sum;
					} else {
						break;
					}
					++i;
				}
				unicodeBinary = unicodeBinary.concat(binaryArray.slice(i + 1, i + 8 - sum));
				i += 8 - sum;
				while (sum > 1) {
					unicodeBinary = unicodeBinary.concat(binaryArray.slice(i + 2, i + 8));
					i += 8;
					--sum;
				}
				unicode = unicode.concat(_toDecimal(unicodeBinary));
				unicodeBinary = [];
			}
		}
		//---------直接转换为结果
		var strResult = '';
		for (var i = 0, len = unicode.length; i < len; ++i) {
			strResult += String.fromCharCode(unicode[i]);
		}
		return strResult;
	}
};

var rotateLeft = function (lValue, iShiftBits) {
	return (lValue << iShiftBits) | (lValue >>> (32 - iShiftBits));
}

var addUnsigned = function (lX, lY) {
	var lX4, lY4, lX8, lY8, lResult;
	lX8 = (lX & 0x80000000);
	lY8 = (lY & 0x80000000);
	lX4 = (lX & 0x40000000);
	lY4 = (lY & 0x40000000);
	lResult = (lX & 0x3FFFFFFF) + (lY & 0x3FFFFFFF);
	if (lX4 & lY4) return (lResult ^ 0x80000000 ^ lX8 ^ lY8);
	if (lX4 | lY4) {
		if (lResult & 0x40000000) return (lResult ^ 0xC0000000 ^ lX8 ^ lY8);
		else return (lResult ^ 0x40000000 ^ lX8 ^ lY8);
	} else {
		return (lResult ^ lX8 ^ lY8);
	}
}

var F = function (x, y, z) {
	return (x & y) | ((~x) & z);
}

var G = function (x, y, z) {
	return (x & z) | (y & (~z));
}

var H = function (x, y, z) {
	return (x ^ y ^ z);
}

var I = function (x, y, z) {
	return (y ^ (x | (~z)));
}

var FF = function (a, b, c, d, x, s, ac) {
	a = addUnsigned(a, addUnsigned(addUnsigned(F(b, c, d), x), ac));
	return addUnsigned(rotateLeft(a, s), b);
};

var GG = function (a, b, c, d, x, s, ac) {
	a = addUnsigned(a, addUnsigned(addUnsigned(G(b, c, d), x), ac));
	return addUnsigned(rotateLeft(a, s), b);
};

var HH = function (a, b, c, d, x, s, ac) {
	a = addUnsigned(a, addUnsigned(addUnsigned(H(b, c, d), x), ac));
	return addUnsigned(rotateLeft(a, s), b);
};

var II = function (a, b, c, d, x, s, ac) {
	a = addUnsigned(a, addUnsigned(addUnsigned(I(b, c, d), x), ac));
	return addUnsigned(rotateLeft(a, s), b);
};

var convertToWordArray = function (string) {
	var lWordCount;
	var lMessageLength = string.length;
	var lNumberOfWordsTempOne = lMessageLength + 8;
	var lNumberOfWordsTempTwo = (lNumberOfWordsTempOne - (lNumberOfWordsTempOne % 64)) / 64;
	var lNumberOfWords = (lNumberOfWordsTempTwo + 1) * 16;
	var lWordArray = Array(lNumberOfWords - 1);
	var lBytePosition = 0;
	var lByteCount = 0;
	while (lByteCount < lMessageLength) {
		lWordCount = (lByteCount - (lByteCount % 4)) / 4;
		lBytePosition = (lByteCount % 4) * 8;
		lWordArray[lWordCount] = (lWordArray[lWordCount] | (string.charCodeAt(lByteCount) << lBytePosition));
		lByteCount++;
	}
	lWordCount = (lByteCount - (lByteCount % 4)) / 4;
	lBytePosition = (lByteCount % 4) * 8;
	lWordArray[lWordCount] = lWordArray[lWordCount] | (0x80 << lBytePosition);
	lWordArray[lNumberOfWords - 2] = lMessageLength << 3;
	lWordArray[lNumberOfWords - 1] = lMessageLength >>> 29;
	return lWordArray;
};

var wordToHex = function (lValue) {
	var WordToHexValue = '', WordToHexValueTemp = '', lByte, lCount;
	for (lCount = 0; lCount <= 3; lCount++) {
		lByte = (lValue >>> (lCount * 8)) & 255;
		WordToHexValueTemp = '0' + lByte.toString(16);
		WordToHexValue = WordToHexValue + WordToHexValueTemp.substr(WordToHexValueTemp.length - 2, 2);
	}
	return WordToHexValue;
};

var uTF8Encode = function (str) {
	str = str.replace(/\x0d\x0a/g, '\x0a');
	var output = '';
	for (var n = 0; n < str.length; n++) {
		var c = str.charCodeAt(n);
		if (c < 128) {
			output += String.fromCharCode(c);
		} else if ((c > 127) && (c < 2048)) {
			output += String.fromCharCode((c >> 6) | 192);
			output += String.fromCharCode((c & 63) | 128);
		} else {
			output += String.fromCharCode((c >> 12) | 224);
			output += String.fromCharCode(((c >> 6) & 63) | 128);
			output += String.fromCharCode((c & 63) | 128);
		}
	}
	return output;
};

var md5 = function (string) {
	var x = Array();
	var k, AA, BB, CC, DD, a, b, c, d;
	var S11 = 7, S12 = 12, S13 = 17, S14 = 22;
	var S21 = 5, S22 = 9, S23 = 14, S24 = 20;
	var S31 = 4, S32 = 11, S33 = 16, S34 = 23;
	var S41 = 6, S42 = 10, S43 = 15, S44 = 21;
	string = uTF8Encode(string);
	x = convertToWordArray(string);
	a = 0x67452301;
	b = 0xEFCDAB89;
	c = 0x98BADCFE;
	d = 0x10325476;
	for (k = 0; k < x.length; k += 16) {
		AA = a;
		BB = b;
		CC = c;
		DD = d;
		a = FF(a, b, c, d, x[k + 0], S11, 0xD76AA478);
		d = FF(d, a, b, c, x[k + 1], S12, 0xE8C7B756);
		c = FF(c, d, a, b, x[k + 2], S13, 0x242070DB);
		b = FF(b, c, d, a, x[k + 3], S14, 0xC1BDCEEE);
		a = FF(a, b, c, d, x[k + 4], S11, 0xF57C0FAF);
		d = FF(d, a, b, c, x[k + 5], S12, 0x4787C62A);
		c = FF(c, d, a, b, x[k + 6], S13, 0xA8304613);
		b = FF(b, c, d, a, x[k + 7], S14, 0xFD469501);
		a = FF(a, b, c, d, x[k + 8], S11, 0x698098D8);
		d = FF(d, a, b, c, x[k + 9], S12, 0x8B44F7AF);
		c = FF(c, d, a, b, x[k + 10], S13, 0xFFFF5BB1);
		b = FF(b, c, d, a, x[k + 11], S14, 0x895CD7BE);
		a = FF(a, b, c, d, x[k + 12], S11, 0x6B901122);
		d = FF(d, a, b, c, x[k + 13], S12, 0xFD987193);
		c = FF(c, d, a, b, x[k + 14], S13, 0xA679438E);
		b = FF(b, c, d, a, x[k + 15], S14, 0x49B40821);
		a = GG(a, b, c, d, x[k + 1], S21, 0xF61E2562);
		d = GG(d, a, b, c, x[k + 6], S22, 0xC040B340);
		c = GG(c, d, a, b, x[k + 11], S23, 0x265E5A51);
		b = GG(b, c, d, a, x[k + 0], S24, 0xE9B6C7AA);
		a = GG(a, b, c, d, x[k + 5], S21, 0xD62F105D);
		d = GG(d, a, b, c, x[k + 10], S22, 0x2441453);
		c = GG(c, d, a, b, x[k + 15], S23, 0xD8A1E681);
		b = GG(b, c, d, a, x[k + 4], S24, 0xE7D3FBC8);
		a = GG(a, b, c, d, x[k + 9], S21, 0x21E1CDE6);
		d = GG(d, a, b, c, x[k + 14], S22, 0xC33707D6);
		c = GG(c, d, a, b, x[k + 3], S23, 0xF4D50D87);
		b = GG(b, c, d, a, x[k + 8], S24, 0x455A14ED);
		a = GG(a, b, c, d, x[k + 13], S21, 0xA9E3E905);
		d = GG(d, a, b, c, x[k + 2], S22, 0xFCEFA3F8);
		c = GG(c, d, a, b, x[k + 7], S23, 0x676F02D9);
		b = GG(b, c, d, a, x[k + 12], S24, 0x8D2A4C8A);
		a = HH(a, b, c, d, x[k + 5], S31, 0xFFFA3942);
		d = HH(d, a, b, c, x[k + 8], S32, 0x8771F681);
		c = HH(c, d, a, b, x[k + 11], S33, 0x6D9D6122);
		b = HH(b, c, d, a, x[k + 14], S34, 0xFDE5380C);
		a = HH(a, b, c, d, x[k + 1], S31, 0xA4BEEA44);
		d = HH(d, a, b, c, x[k + 4], S32, 0x4BDECFA9);
		c = HH(c, d, a, b, x[k + 7], S33, 0xF6BB4B60);
		b = HH(b, c, d, a, x[k + 10], S34, 0xBEBFBC70);
		a = HH(a, b, c, d, x[k + 13], S31, 0x289B7EC6);
		d = HH(d, a, b, c, x[k + 0], S32, 0xEAA127FA);
		c = HH(c, d, a, b, x[k + 3], S33, 0xD4EF3085);
		b = HH(b, c, d, a, x[k + 6], S34, 0x4881D05);
		a = HH(a, b, c, d, x[k + 9], S31, 0xD9D4D039);
		d = HH(d, a, b, c, x[k + 12], S32, 0xE6DB99E5);
		c = HH(c, d, a, b, x[k + 15], S33, 0x1FA27CF8);
		b = HH(b, c, d, a, x[k + 2], S34, 0xC4AC5665);
		a = II(a, b, c, d, x[k + 0], S41, 0xF4292244);
		d = II(d, a, b, c, x[k + 7], S42, 0x432AFF97);
		c = II(c, d, a, b, x[k + 14], S43, 0xAB9423A7);
		b = II(b, c, d, a, x[k + 5], S44, 0xFC93A039);
		a = II(a, b, c, d, x[k + 12], S41, 0x655B59C3);
		d = II(d, a, b, c, x[k + 3], S42, 0x8F0CCC92);
		c = II(c, d, a, b, x[k + 10], S43, 0xFFEFF47D);
		b = II(b, c, d, a, x[k + 1], S44, 0x85845DD1);
		a = II(a, b, c, d, x[k + 8], S41, 0x6FA87E4F);
		d = II(d, a, b, c, x[k + 15], S42, 0xFE2CE6E0);
		c = II(c, d, a, b, x[k + 6], S43, 0xA3014314);
		b = II(b, c, d, a, x[k + 13], S44, 0x4E0811A1);
		a = II(a, b, c, d, x[k + 4], S41, 0xF7537E82);
		d = II(d, a, b, c, x[k + 11], S42, 0xBD3AF235);
		c = II(c, d, a, b, x[k + 2], S43, 0x2AD7D2BB);
		b = II(b, c, d, a, x[k + 9], S44, 0xEB86D391);
		a = addUnsigned(a, AA);
		b = addUnsigned(b, BB);
		c = addUnsigned(c, CC);
		d = addUnsigned(d, DD);
	}
	var tempValue = wordToHex(a) + wordToHex(b) + wordToHex(c) + wordToHex(d);
	return tempValue.toLowerCase();
}
var base64EncodeChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var base64DecodeChars = new Array(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1);
/**
 * base64编码
 * @param {Object} str
 */
function base64encode (str) {
	var out, i, len;
	var c1, c2, c3;
	len = str.length;
	i = 0;
	out = '';
	while (i < len) {
		c1 = str.charCodeAt(i++) & 0xff;
		if (i == len) {
			out += base64EncodeChars.charAt(c1 >> 2);
			out += base64EncodeChars.charAt((c1 & 0x3) << 4);
			out += '==';
			break;
		}
		c2 = str.charCodeAt(i++);
		if (i == len) {
			out += base64EncodeChars.charAt(c1 >> 2);
			out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
			out += base64EncodeChars.charAt((c2 & 0xF) << 2);
			out += '=';
			break;
		}
		c3 = str.charCodeAt(i++);
		out += base64EncodeChars.charAt(c1 >> 2);
		out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
		out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6));
		out += base64EncodeChars.charAt(c3 & 0x3F);
	}
	return out;
}
/**
 * base64解码
 * @param {Object} str
 */
function base64decode (str) {
	var c1, c2, c3, c4;
	var i, len, out;
	len = str.length;
	i = 0;
	out = '';
	while (i < len) {
		/* c1 */
		do {
			c1 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
		}
		while (i < len && c1 == -1);
		if (c1 == -1)
			break;
		/* c2 */
		do {
			c2 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
		}
		while (i < len && c2 == -1);
		if (c2 == -1)
			break;
		out += String.fromCharCode((c1 << 2) | ((c2 & 0x30) >> 4));
		/* c3 */
		do {
			c3 = str.charCodeAt(i++) & 0xff;
			if (c3 == 61)
				return out;
			c3 = base64DecodeChars[c3];
		}
		while (i < len && c3 == -1);
		if (c3 == -1)
			break;
		out += String.fromCharCode(((c2 & 0XF) << 4) | ((c3 & 0x3C) >> 2));
		/* c4 */
		do {
			c4 = str.charCodeAt(i++) & 0xff;
			if (c4 == 61)
				return out;
			c4 = base64DecodeChars[c4];
		}
		while (i < len && c4 == -1);
		if (c4 == -1)
			break;
		out += String.fromCharCode(((c3 & 0x03) << 6) | c4);
	}
	return out;
}  