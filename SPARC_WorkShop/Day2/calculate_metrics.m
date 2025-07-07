function [accuracy, sensitivity, specificity] = calculate_metrics(targets, outputs)

    % Calculate True Positives, True Negatives, False Positives, False Negatives
    TP = sum((outputs == 1) & (targets == 1));
    TN = sum((outputs == 0) & (targets == 0));
    FP = sum((outputs == 1) & (targets == 0));
    FN = sum((outputs == 0) & (targets == 1));

    % Calculate accuracy, sensitivity, specificity
    accuracy = (TP + TN) / (TP + TN + FP + FN);
    sensitivity = TP / (TP + FN);
    specificity = TN / (TN + FP);


end

