#!/usr/bin/perl
use strict;
use warnings;
use POSIX;

my $input_string = <STDIN>;
chomp $input_string;

# Find the approximate number of rows and columns
# by finding the nearest integer square root
my $input_length = length $input_string;
my $rows = ceil(sqrt($input_length));
my $cols = $rows;
my $optimal_rows = $rows;
my $optimal_cols = $cols;

# Find the optimal number of rows and columns
# by decreasing the number of rows first and
# then decreasing the number of columns
$rows--;
if (($rows * $cols) >= $input_length) {
	$optimal_rows = $rows;
	$cols--;
	if (($rows * $cols) >= $input_length) {
		$optimal_cols = $cols;
	}
}

# Populate the array
my @encrypted_array = ();
for (my $current_row = 0; $current_row < $optimal_rows; $current_row++) {
	my $current_row_string = substr($input_string, $current_row * $optimal_cols, $optimal_cols);
	my @current_row_array = split(//,$current_row_string);
	$encrypted_array[$current_row] = \@current_row_array;
}

# Print the encrypted string using column major order
for (my $current_col = 0; $current_col < $optimal_cols; $current_col++) {
	for (my $current_row = 0; $current_row < $optimal_rows; $current_row++) {
		if ($encrypted_array[$current_row][$current_col]) {
			print $encrypted_array[$current_row][$current_col];
		}
	}
	print " ";
}
