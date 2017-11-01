local agent = require 'lib.agent'

local mission_names = {
  'asserts',
  'variables',
  'numbers',
  'strings',
  'patterns',
  'control',
  'truthiness',
  'functions',
  'errors',
  'load',
  'tables',
  'tables_and_functions',
  'coroutines',
  'meta',
  'indices',
  'exercise',
  'weak_tables'
}

local missions = {}

for _, name in ipairs(mission_names) do
  table.insert(missions, { name = name, path = name .. '.lua' })
end

local a = agent.new(missions)

os.exit(a:execute())
