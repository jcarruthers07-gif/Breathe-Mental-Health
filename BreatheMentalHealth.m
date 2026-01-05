%% Breathing functions
% they all take in a myscene variable to avoid the creation of multiple
% firgures due to running simple game engine multiple times
% also take in a tempo variable (factor to multiply but orignal suggested numbers)
% which gives personalization
% reps so the user doesnt have to keep running through the loop 
function stressed(myScene, tempo, reps)
    tree = 33;
    display = ones(5,9); 
    display([2,4],:) = tree;
    % creates loop that does breathing excerise for as many reps a user
    % chooses
    for i = 1:reps
        % inhale
        countdown(myScene, display, 4*tempo, 4,'Inhale');
        % hold
        countdown(myScene, display, 4*tempo, 4,'Hold');
        % exhale
        countdown(myScene, display, 4*tempo, 4,'Exhale');
        % hold
        countdown(myScene, display, 4*tempo, 4,'Hold');
    end
end

function restless(myScene, tempo, reps)
    tree = 33;
    display = ones(5,9); 
    display([2,4],:) = tree;

    for i = 1:reps
        % inhale
        countdown(myScene, display, 4*tempo, 4,'Inhale');
        % hold
        countdown(myScene, display, 7*tempo, 7,'Hold');
        % exhale
        countdown(myScene, display, 8*tempo, 8,'Exhale');
    end
end

function unfocused(myScene, tempo, reps)
    tree = 33;
    display = ones(5,9); 
    display([2,4],:) = tree;
% uses reps * 4 beause excerise is very short
    for i = 1:reps*4
        % inhale
        countdown(myScene, display, 1*tempo, 1,'Focus: Inhale');
        % exhale 
        countdown(myScene, display, 1*tempo, 1,'Focus: Exhale');
    end
end

%% Helper function for countdown
% myScene and home to use the same figure window 
% time for how long it should be
% numIncr for how many times it should redisplay the time left
% instrucitons to tell user to inhale exhale etc
function countdown(myScene, display, time, numIncr, instructions)
    t = time;
    % like math chagne in x = range/n
    % have to use variables because the tempo changes the time
    incr = t/numIncr;
    % delta x = b-a/n typa thing
    while t > 0
        drawScene(myScene, display);
        % uses num2str and %.2f to convert time to str for display with 2 decimal
        % points so when tempo chnages you can see the new time 
        text(360, 200, [instructions ' (' num2str(t,"%.2f") ' sec)...'], ...
             'FontSize',12,'Color',[0,1,0],'HorizontalAlignment','center');
        pause(incr); 
        cla;
        t = t - incr;
    end
end

%% Main Script
% creating backscreen of trees for relaxation
figure('Units','normalized','OuterPosition',[0 0 1 1])
myScene = simpleGameEngine('retro_pack.png',16,16,5,[90 45 45]);
tree = 33;
display = ones(5,9);
% makes 2nd row and 4th row all columns trees
display([2,4],:) = tree;
playAgain = 'y';
tempo = 1;
% While loop for infinite replayability
while playAgain == 'y' || playAgain == 'Y'
    cla;
    drawScene(myScene,display)
    text(360,200, ...
        ["Welcome!" ...
         "How are you feeling? (stressed, restless, or unfocused)" ...
         "Input the first letter of your choice"], ...
        "FontSize",12,"Color",[0,1,0],"HorizontalAlignment","center");
    userFeel = getKeyboardInput(myScene);
    % userproof to ensure input of valid key
    % inifinite loop untill satisfied with input
    while ~contains("sSrRuU",userFeel)
        cla;
        drawScene(myScene,display);
        text(360,200,"Enter either s = stressed, u = unfocused, or r = restless", ...
            "FontSize",12,"Color",[0,1,0],"HorizontalAlignment","center")
        userFeel = getKeyboardInput(myScene);
    end
    cla;
    drawScene(myScene,display)
    text(360,200,"How many reps would you like to do?",...
        "FontSize",12,"Color",[0,1,0],"HorizontalAlignment","center")
    reps = str2double(getKeyboardInput(myScene));
    cla;
    % userproof to ensure input of valid key
    % inifinite loop untill satisfied with input
    while isnan(reps)
        cla;
        drawScene(myScene,display);
        text(360,200,"Enter a number 1-9","FontSize",12, ...
            "Color",[0,1,0],"HorizontalAlignment","center")
        reps = str2double(getKeyboardInput(myScene));
    end
    if userFeel == 's' || userFeel == 'S'
        stressed(myScene, tempo, reps)
    elseif userFeel == 'r' || userFeel == 'R'
        restless(myScene, tempo, reps)
    elseif userFeel == 'u' || userFeel == 'U'
        unfocused(myScene, tempo, reps)
    end
    % ask how the pacing was
    cla;
    drawScene(myScene,display);
    text(360,200,["How was the tempo?" ...
                  "(s = slow, f = fast, g = good)" ...
                  "Press r to reset breathing pace"], ...
         "FontSize",12,"Color",[0,1,0],"HorizontalAlignment","center");
    tempoFeedback = getKeyboardInput(myScene);
    % userproof to ensure input of valid key
    % inifinite loop untill satisfied with input
    while ~contains("sSrRgGfF",tempoFeedback)
        cla;
        drawScene(myScene,display);
        text(360,200,"Enter either s = slow, f = fast, g = good or Press r to reset breathing pace", ...
            "FontSize",12,"Color",[0,1,0],"HorizontalAlignment","center")
        tempoFeedback = getKeyboardInput(myScene);
    end
    % adjust tempo variable based on feel of pacing
    if tempoFeedback == 's' || tempoFeedback == 'S'
        tempo = tempo - 0.1;
    elseif tempoFeedback == 'f' || tempoFeedback == 'F'
        tempo = tempo + 0.1;
    elseif tempoFeedback == 'r' || tempoFeedback == 'R'
        tempo = 1;
    elseif tempoFeedback == 'g' || tempoFeedback == 'G'
       % stay the same
    end
    cla;
    drawScene(myScene,display);
    text(360,200,"Do you want to play again?(y=Yes n=No)", ...
        "FontSize",12,"Color",[0,1,0],"HorizontalAlignment","center")
    playAgain = getKeyboardInput(myScene);

    if playAgain == 'n'|| playAgain == 'N'
        cla;
        drawScene(myScene,display);
        text(360,200,"Thank you for playing, hope you feel better!!", ...
            "FontSize",12,"Color",[0,1,0],"HorizontalAlignment","center")
    end
end