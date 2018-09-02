/* @flow */

import React, { PropTypes } from 'react'
import { ScrollView } from 'react-native'
import KeyboardAwareMixin from './KeyboardAwareMixin'

const KeyboardAwareScrollView = React.createClass({
	propTypes: {
		...ScrollView.propTypes,
		viewIsInsideTabBar: PropTypes.bool,
		resetScrollToCoords: PropTypes.shape({
			x: PropTypes.number,
			y: PropTypes.number,
		}),
	},
	mixins: [KeyboardAwareMixin],

	componentWillMount: function () {
		this.setViewIsInsideTabBar(this.props.viewIsInsideTabBar)
		this.setResetScrollToCoords(this.props.resetScrollToCoords)
	},

	getScrollResponder () {
		return this._rnkasv_keyboardView.getScrollResponder()
	},

	render: function () {
		return (
			<ScrollView
				ref={ ref => { this._rnkasv_keyboardView = ref }}
				keyboardDismissMode="interactive"
				contentInset={{ bottom: this.state.keyboardSpace }}
				showsVerticalScrollIndicator={true}
				automaticallyAdjustContentInsets={false}
				{...this.props}
				style={[{ flex: 1, ...this.props.style }]}
				scrollEventThrottle={8}
				onScroll={e => {
					this.handleOnScroll(e)
					this.props.onScroll && this.props.onScroll(e)
				}}
			>
				{this.props.children}
			</ScrollView>
		)
	},
})

export default KeyboardAwareScrollView