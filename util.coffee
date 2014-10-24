Mocha = module.parent.require 'mocha'

module.exports =
  # Run specfied hook on specified suite
  # invoking the callback on completion
  runHook: (suite, hook, cb) =>
    runner = new Mocha.Runner @suite
    runner.hook hook, =>
      cb()

