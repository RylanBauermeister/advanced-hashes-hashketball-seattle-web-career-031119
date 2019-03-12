# Write your code here!
require 'pry'

def game_hash
  {
    home: {
      team_name:"Brooklyn Nets",
      colors: ["Black", "White"],
      players:{
        "Alan Anderson" => {
          number: 0,
          shoe: 16,
          points: 22, 
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1 
        },
        "Reggie Evans" => {
          number: 30,
          shoe: 14,
          points: 12, 
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7           
        },
        "Brook Lopez" => {
          number: 11,
          shoe: 17,
          points: 17, 
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15 
        },
        "Mason Plumlee" => {
          number: 1,
          shoe: 19,
          points: 26, 
          rebounds: 12,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5 
        },
        "Jason Terry" => {
          number: 31,
          shoe: 15,
          points: 19, 
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1 
        }
      }
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: {
        "Jeff Adrien" => {
          number: 4,
          shoe: 18,
          points: 10, 
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2 
        },
        "Bismak Biyombo" => {
          number: 0,
          shoe: 16,
          points: 12, 
          rebounds: 4,
          assists: 7,
          steals: 7,
          blocks: 15,
          slam_dunks: 10           
        },
        "DeSagna Diop" => {
          number: 2,
          shoe: 14,
          points: 24, 
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5 
        },
        "Ben Gordon" => {
          number: 8,
          shoe: 15,
          points: 33, 
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0 
        },
        "Brendan Haywood" => {
          number: 33,
          shoe: 15,
          points: 6, 
          rebounds: 12,
          assists: 12,
          steals: 22,
          blocks: 5,
          slam_dunks: 12 
        }
      }
    }
  }
end

def get_player(name)
  if game_hash[:home][:players].include?(name)
    return game_hash[:home][:players][name]
  else 
    return game_hash[:away][:players][name]
  end
end

def num_points_scored(name)
  get_player(name)[:points]
end

def shoe_size(name)
  get_player(name)[:shoe]
end  

def team_colors(team)
  game_hash[:home][:team_name] == team ? 
    game_hash[:home][:colors] : 
    game_hash[:away][:colors]
end

def team_names
  game_hash.collect {|team, data|
    data[:team_name]
  }
end

def player_numbers(targetTeam)
  teamData = game_hash.select{|team, data| data[:team_name] == targetTeam}
  teamData[teamData.keys[0]][:players].map{|name, info|
    info[:number]
  }
end

def player_stats(name)
  game_hash[:home][:players].include?(name) ? 
  game_hash[:home][:players][name] 
  : game_hash[:away][:players][name]
end

def big_shoe_rebounds
  player_with_most(:shoe)[:rebounds]
end

def player_with_most(attribute)
  biggest = {}
  biggest[attribute] = 0
  game_hash.each do |team, data|
    data[:players].each do |player, info|
      if info[attribute] > biggest[attribute]
        biggest = info
        biggest[:name] = player
      end
    end
  end
  biggest
end

def most_points_scored
  player_with_most(:points)[:name]
end


def winning_team
  awayTotal = 0
  homeTotal = 0
  
  game_hash[:home][:players].each do |player, info|
    homeTotal += info[:points].to_i
  end
  game_hash[:away][:players].each do |player, info|
    awayTotal += info[:points].to_i
  end
  
  awayTotal > homeTotal ? game_hash[:away][:team_name] : 
  game_hash[:home][:team_name]
end

def player_with_longest_name
  longest = 0
  longestName = ""
  game_hash.each do |teamName, teamInfo|
    teamInfo[:players].keys.map {|key| 
      if key.length > longest
        longestName = key
      end
    }
  end
  longestName
end

def long_name_steals_a_ton?
  player_with_longest_name == player_with_most(:steals)[:name]
end
