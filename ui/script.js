let jobs = []; // This will store the jobs from the config

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "openNUI") {
        console.log("Received openNUI message");
        const npcDialog = document.getElementById('npc-dialog');
        npcDialog.classList.remove('hidden');
        // Trigger reflow
        void npcDialog.offsetWidth;
        npcDialog.classList.add('visible');
        jobs = item.jobs; // Store the jobs
    }
});

function closeNUI() {
    console.log("Closing NUI");
    const npcDialog = document.getElementById('npc-dialog');
    npcDialog.classList.remove('visible');
    // Wacht tot de animatie klaar is voordat we de NUI volledig verbergen
    setTimeout(() => {
        npcDialog.classList.add('hidden');
        document.getElementById('main-content').classList.remove('hidden');
        document.getElementById('jobs-content').classList.add('hidden');
    }, 500); // 500ms is de duur van de animatie

    fetch(`https://${GetParentResourceName()}/closeNUI`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => console.log(resp));
}

function populateJobs() {
    console.log("Populating jobs");
    var jobList = document.getElementById('job-list');
    jobList.innerHTML = '';
    jobs.forEach(function(job) {
        var jobItem = document.createElement('div');
        jobItem.className = 'job-item';
        jobItem.innerHTML = `
            <img src="${job.image}" alt="${job.label}">
            <h3>${job.label}</h3>
            <button onclick="selectJob('${job.name}')">Select</button>
        `;
        jobList.appendChild(jobItem);
    });
}

function selectJob(jobName) {
    console.log("Job selected: " + jobName);
    fetch(`https://${GetParentResourceName()}/selectJob`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            job: jobName
        })
    }).then(resp => resp.json()).then(resp => console.log(resp));
    closeNUI();
}


// Event listener voor de close button
document.getElementById('close-btn').addEventListener('click', closeNUI);

// Event listener voor de "Show Available Jobs" button
document.getElementById('show-jobs-btn').addEventListener('click', function() {
    document.getElementById('main-content').classList.add('hidden');
    document.getElementById('jobs-content').classList.remove('hidden');
    populateJobs();
});

document.getElementById('back-btn').addEventListener('click', function() {
    document.getElementById('jobs-content').classList.add('hidden');
    document.getElementById('main-content').classList.remove('hidden');
});
// Event listener voor de ESC toets
document.addEventListener('keydown', function(event) {
    if (event.key === "Escape") {
        closeNUI();
    }
});
