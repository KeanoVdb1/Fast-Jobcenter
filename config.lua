Config = {}

Config.NPC = {
    model = "a_m_m_business_01",
    coords = vector4(-265.9360, -968.0476, 31.2239, 67.9646),
    scenario = "WORLD_HUMAN_STAND_IMPATIENT"
}

Config.AllowedJobs = {
    {name = "police", label = "Police", image = "https://pvo-nl.nl/wp-content/uploads/2023/06/politie-embleem.png"},
    {name = "ambulance", label = "Ambulance", image = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Star_of_life2.svg/800px-Star_of_life2.svg.png"},
    {name = "mechanic", label = "Mechanic", image = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vectorstock.com%2Froyalty-free-vector%2Fmechanic-logo-vector-44593140&psig=AOvVaw2vn5yrOxy5PG7ZT88IcXTP&ust=1739810365027000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCOj-n-jQyIsDFQAAAAAdAAAAABAJ"},
    -- Voeg meer jobs toe zoals nodig
}

Config.NotificationSystem = 'ox_lib' -- Mogelijke waarden: 'esx', 'ox_lib', 'custom'

Config.CustomNotify = function(msg)
    -- Voeg hier je eigen notificatie logica toe als je 'custom' gebruikt
    -- Bijvoorbeeld:
    -- exports['mythic_notify']:DoHudText('inform', msg)
end

Config.Lang = {
    interact = "Talk to Job Center NPC",
    notAllowed = "You don't have access to this NPC"
}

Config.Notifications = {
    Title = 'Job Center',
    Type = 'info',
    JobSet = 'Je bent nu aangenomen als %s!',
    JobNotExist = 'Deze baan bestaat niet!',
    PlayerNotFound = 'Speler niet gevonden bij het instellen van de baan.'
}

Config.DebugMessages = {
    PlayerInteraction = "Speler heeft interactie gehad met Job Center NPC",
    AttemptingSetJob = "Poging om baan in te stellen: %s",
    PlayerNotFound = "Speler niet gevonden bij het instellen van de baan"
}