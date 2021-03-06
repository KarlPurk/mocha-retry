Q = require 'q'
times = 0

describe 'Some suite with before and no retry', ->
  valueAll = 0
  before ->
    valueAll += 2
    if valueAll isnt 2 then throw new Error "has to be 2"
  it 'verifies the value', -> valueAll.should.equal 2
  it 'verifies the value again', -> valueAll.should.equal 2

describe 'Some suite with before with retry', ->
  valueAll = 0
  before 2, ->
    valueAll++
    if valueAll isnt 2 then throw new Error "at least 2"
  it 'verifies the value', -> valueAll.should.equal 2
  it 'verifies the value again', -> valueAll.should.equal 2

describe 'Some suite with beforeEach and no retry', ->
  valueEach = 0
  beforeEach ->
    valueEach += 2
    if valueEach % 2 isnt 0 then throw new Error "isnt even"
  it 'verifies the value once', -> valueEach.should.equal 2
  it 'verifies the value twice', -> valueEach.should.equal 4

describe 'Some suite with beforeEach with retry', ->
  valueEach = 0
  beforeEach 2, ->
    valueEach++
    if valueEach % 2 isnt 0 then throw new Error "isnt even"
  it 'verifies the value once', -> valueEach.should.equal 2
  it 'verifies the value twice', -> valueEach.should.equal 4

describe 'Before all using global default retry', ->
  global.DEFAULT_RETRY = 2
  describe 'inner suite (needed to apply global retry)', ->
    valueAll = 0
    before ->
      valueAll++
      if valueAll isnt 2 then throw new Error "at least 2"
    it 'verifies the value', -> valueAll.should.equal 2
    it 'verifies the value again', -> valueAll.should.equal 2
delete global.DEFAULT_RETRY

describe 'Before all With global default retry but overriding it', ->
  global.DEFAULT_RETRY = 2
  before -> times = 0
  describe 'inner suite with specific retry (needed to apply global retry)', ->
    valueAll = 0
    before 3, ->
      valueAll++
      if valueAll isnt 3 then throw new Error "at least 3"
    it 'verifies the value', -> valueAll.should.equal 3
    it 'verifies the value again', -> valueAll.should.equal 3
delete global.DEFAULT_RETRY

describe 'Before each using global default retry', ->
  global.DEFAULT_RETRY = 2
  describe 'inner suite (needed to apply global retry)', ->
    valueEach = 0
    beforeEach ->
      valueEach++
      if valueEach % 2 isnt 0 then throw new Error "isnt even"
    it 'verifies the value once', -> valueEach.should.equal 2
    it 'verifies the value twice', -> valueEach.should.equal 4
delete global.DEFAULT_RETRY

describe 'Before each With global default retry but overriding it', ->
  global.DEFAULT_RETRY = 2
  before -> times = 0
  describe 'inner suite with specific retry (needed to apply global retry)', ->
    valueEach = 0
    beforeEach 3, ->
      valueEach++
      if valueEach % 3 isnt 0 then throw new Error "isnt three"
    it 'verifies the value once', -> valueEach.should.equal 3
    it 'verifies the value twice', -> valueEach.should.equal 6
delete global.DEFAULT_RETRY

