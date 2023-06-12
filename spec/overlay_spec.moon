overlay = require 'overlay'

describe 'Overlayed table', ->
	before_each -> export overlayed = overlay(
		{"foo", nested: {"FOO"}, problem: 20 },
		{"bar", "bar", nested: {"BAR", "BAR"}, problem: {solved: "UwU"}}
	)
	it 'correctly indexes a single layer', ->
		assert.equal "foo", overlayed\get(1)
		assert.equal "bar", overlayed\get(2)
	it 'corretly indexes nested structures', ->
		assert.equal "FOO", overlayed\get('nested', 1)
		assert.equal "BAR", overlayed\get('nested', 2)
	it 'errors when something fails', ->
		assert.errors ->
			overlayed\get 'problem', 'solved'
	describe 'pget', ->
		it 'skips erroring tables', ->
			assert.equal "UwU", overlayed\pget 'problem', 'solved'
	describe 'xpget', ->
		it 'skips erroring tables', ->
			assert.equal "UwU", overlayed\xpget (->), 'problem', 'solved'
		it 'calls the handler on errors', ->
			handler = spy ->
			overlayed\xpget handler, 'problem', 'solved'
			assert.spy(handler).was.called()
