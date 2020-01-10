httr::user_agent(
  sprintf("fixthis package v%s: (<%s>)",
          utils::packageVersion("fixthis"),
          utils::packageDescription("fixthis")$URL)
) -> .fixthis_ua
