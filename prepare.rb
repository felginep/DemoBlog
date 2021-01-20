#!/usr/bin/env ruby

require 'yaml'

def run(env)
  yml = YAML.load(File.read("DemoBlog/Environment/env.#{env}.yml"))
  pbxproj_values = yml["pbxproj"]
  env_values = yml["env"]
  heading = "\n// Environment: #{env}\n"
  write_xcconfig(pbxproj_values, heading)
  write_env(env_values, heading)
end

def write_xcconfig(values, heading)
  xcconfig_content = heading + "\n" + values
    .map { |key, value| "#{key} = #{value}" }
    .join("\n")
  path = File.expand_path("DemoBlog/BuildConfig/Environment.xcconfig")
  File.write(path, xcconfig_content)
  puts "Sucessfully copied values to #{path}"
end

def write_env(values, heading)
  env_properties = File.readlines("DemoBlog/Environment/Environment.swift")
    .map { |line| line[/let (\w*):/, 1] }
    .compact

  indent = (0..7).map { " " }.join("")
  final_values = values
  .sort_by { |tuple| env_properties.index(tuple[0]) || 0 }
  .to_h
  .map { |key, value|
    if value.is_a? String
      "#{key}: \"#{value}\""
    else
      "#{key}: #{value}"
    end
  }
  .map { |value| "#{indent}#{value}" }
  .join(",\n")

  content = """import Foundation
#{heading}
extension Environment {
    static let current = Environment(
#{final_values}
    )
}
"""
  path = File.expand_path("DemoBlog/Environment/Environment+Current.swift")
  File.write(path, content)
  puts "Sucessfully copied values to #{path}"
end

run(ARGV[0])
