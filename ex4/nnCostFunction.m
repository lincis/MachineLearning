function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices.
%
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);

% You need to return the following variables correctly
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

X = [ones(m, 1) X];

a2 = [ones(m, 1) sigmoid(X * Theta1')];
a3 = sigmoid(a2 * Theta2');
reference = zeros(m, num_labels);
reference(sub2ind(size(reference),1:m,y')) = 1;
J = 1/m * sum(sum(-reference .* log(a3) - (1 - reference) .* log(1 - a3))) + ...
    lambda / (2 * m) * (sum ( Theta1(:,2:input_layer_size + 1)(:) .^2 ) + sum( Theta2(:,2:hidden_layer_size + 1)(:) .^2 ) );

Delta2 = zeros(size(Theta2));
Delta1 = zeros(size(Theta1));
%for i = 1:m
%    a1 = (X(i,:))';
%    printf("a1 = %d x %d\n", size(a1));
%    z2 = Theta1 * a1;
%    printf("z2 = %d x %d\n", size(z2));
%    a2 = [1; sigmoid(z2)];
%    printf("a2 = %d x %d\n", size(a2));
%    z3 = Theta2 * a2;
%    printf("z3 = %d x %d\n", size(z3));
%    a3 = sigmoid(z3);
%    printf("a3 = %d x %d\n", size(a3));
%    printf("ref full = %d x %d\n", size(reference));
%    printf("ref slice = %d x %d\n", size(reference(i,:)));
%    delta3 = a3 - reference(i,:)';
%    printf("d3 = %d x %d\n", size(delta3));
%    delta2 = (Theta2' * delta3)  .* [0; sigmoidGradient(z2)];
%    printf("d2 = %d x %d\n", size(delta2));
%    Delta2 = Delta2 + delta3 * a2';
%    printf("D2 = %d x %d\n", size(Delta2));
%    Delta1 = Delta1 + delta2(2:end) * a1';
%    printf("D1 = %d x %d\n", size(Delta1));
%    break
%end
a1 = X';
z2 = Theta1 * a1;
a2 = [ones(1,size(z2,2)); sigmoid(z2)];
z3 = Theta2 * a2;
a3 = sigmoid(z3);
delta3 = a3 - reference';
delta2 = (Theta2' * delta3) .* [zeros(1,size(z2,2)); sigmoidGradient(z2)];
Delta2 = delta3 * a2';
Delta1 = delta2(2:end,:) * a1';

Theta1_grad = 1/m * Delta1;
Theta2_grad = 1/m * Delta2;
Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + lambda/m * Theta1(:,2:end);
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + lambda/m * Theta2(:,2:end);
%printf("Theta1_grad = %d x %d\n", size(Theta1_grad));
%printf("Theta2_grad = %d x %d\n", size(Theta2_grad));


% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%



















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
