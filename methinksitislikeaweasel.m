clear
clc

target_string = 'METHINKS IT IS LIKE A WEASEL';

% 1. Start with a random string of 28 characters
length = numel(target_string);
random_string = char(floor(94*rand(1, length)) + 32);
number_of_iterations_so_far = 1;
while 1
    % 2. Make 100 copies of the string (reproduce)
    copies = cell(1,100);
    scores = zeros(1,100);
    for i = 1 : numel(copies)
        copies{i} = random_string;
    end

    % 3. For each character in each of the 100 copies, with a probability of 5%, 
    % replace (mutate) the character with a new random character.    
    for i = 1 : numel(copies)
        for j = 1 : numel(copies{i})
            if rand <= 0.05
                new_random_character = char(floor(94*rand(1, 1)) + 32);
                copies{i}(j) = new_random_character;
            end
        end
    end
    
    % 4. Compare each new string with the target string "METHINKS IT IS LIKE A WEASEL", 
    % and give each a score (the number of letters in the string that are 
    % correct and in the correct position).
    best_score = -1;
    for i = 1 : numel(copies)
        for j = 1 : numel(copies{i})
            if strcmp(target_string(j), copies{i}(j)) == 1
                scores(i) = scores(i) + 1;
            end
        end
        if best_score < scores(i)
            best_score = scores(i);
            best_str = copies{i};
            fprintf('Best string: %s with score %f in iteration %d \n', best_str, best_score, number_of_iterations_so_far);
        end
    end
    
    % 5. If any of the new strings has a perfect score (28), halt. Otherwise, take the highest scoring string, and go to step 2.
    this_is_the_end = 0;
    for i = 1 : numel(copies)
        if scores(i) == numel(target_string)
            this_is_the_end = 1;
        end
    end
    if this_is_the_end == 1
        break;
    end
    
    random_string = best_str;
    number_of_iterations_so_far = number_of_iterations_so_far + 1;
end

