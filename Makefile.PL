
use strict;
use warnings;

 BEGIN { require 5.008; } 

use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Dist::Zilla::App::Command::prereqs',
                       'DISTNAME' => 'Dist-Zilla-App-Command-prereqs',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.11'
                                               },
                       'AUTHOR' => 'Marcel Gruenauer <marcel@cpan.org>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'print your distribution\'s prerequisites',
                       'EXE_FILES' => [],
                       'VERSION' => '1.100750',
                       'PREREQ_PM' => {
                                        'Scalar::Util' => '0',
                                        'Capture::Tiny' => '0',
                                        'Dist::Zilla::App' => '0',
                                        'English' => '0',
                                        'Moose::Autobox' => '0',
                                        'Carp' => '0',
                                        'Test::More' => '0',
                                        'File::Find' => '0',
                                        'File::Temp' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



