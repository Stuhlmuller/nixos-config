{ user, ... }:
{
  imports = [
    ./aliases
    ./programs
  ];

  system.primaryUser = user.name;
}
