# workout program demonstrationg mixin

module ExerciseAlgorithms
  class LiftPercentage
    def calc_perc(rep, lift)
      if rep > 1
        percent_lift = 100 - ((rep * 2) + (rep / 2))
        rep.even? ? (lift * (percent_lift / 100.to_f)) : (lift * ((percent_lift - 1) / 100.to_f))
      else
        lift * (100 / 100.to_f)
      end
    end
  end

  def body_fat(weight, waist)
    calc1 = ((weight * 1.082) + 94.42).to_f
    calc2 = (waist * 4.15).to_f
    lbm = calc1 - calc2
    bf_weight = weight.to_f - lbm
    (bf_weight * 100) / weight.to_f
  end

  def one_rep(rep, lift)
    if rep == 0 || rep.nil?
      nil
    else
      LiftPercentage.new.calc_perc(rep, lift)
    end
  end

  def print_message(gym)
    puts "WorkoutTracker for #{gym}"
  end
end

class Exercise
  include ExerciseAlgorithms
  def goal
    goal = {}
    @input.each do |k, v|
      if v[:lift][0] == 'bench'
        goal[k] = "#{v[:lift][0]} goal is #{one_rep(v[:lift][1], v[:lift][2]) * 2}"
      else
        goal[k] = "#{v[:lift][0]} goal is #{one_rep(v[:lift][1], v[:lift][2])}"
      end
    end
    print_user_goal(goal)
  end

  private

  def print_user_goal(goal)
    goal.each do |k, v|
      puts "#{k} #{v}"
    end
  end
end

class Person < Exercise
  include ExerciseAlgorithms
  def initialize(input)
    @input = input
  end

  def print_user_bodyfat
    @input.each do |k, v|
      puts "#{k} bodyfat is #{body_fat(v[:body][0], v[:body][1])}"
    end
  end
end

test = Person.new(name: { lift: ['bench', 1, 250], body: [190, 36] },
                  name2: { lift: ['squat', 1, 250], body: [250, 36] })
test.print_message("Golds")
test.print_user_bodyfat
test.goal
