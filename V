const API = "http://localhost:5000/api";

const patientForm = document.getElementById("patientForm");

patientForm.addEventListener("submit", async function(event) {

    event.preventDefault();

    const patientData = {
        name: document.getElementById("name").value,
        age: Number(document.getElementById("age").value),
        gender: document.getElementById("gender").value,
        phone: document.getElementById("phone").value,
        disease: document.getElementById("disease").value
    };

    try {

        const response = await fetch(`${API}/patients`, {
            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },

            body: JSON.stringify(patientData)
        });

        const result = await response.json();

        document.getElementById("patientMsg").textContent =
            result.message || result.error;

        patientForm.reset();

        loadPatients();

    } catch (error) {

        document.getElementById("patientMsg").textContent =
            "Backend server is not running.";

    }

});


async function loadPatients() {

    try {

        const response = await fetch(`${API}/patients`);

        const patients = await response.json();

        document.getElementById("patients").innerHTML =
            patients.map(patient => `

                <div class="patient">

                    <b>${patient.name}</b>

                    <br>

                    Age: ${patient.age}

                    <br>

                    Gender: ${patient.gender}

                    <br>

                    Phone: ${patient.phone || "Not Available"}

                    <br>

                    Disease:
                    ${patient.disease || "Not Available"}

                </div>

            `).join("");

    } catch (error) {

        document.getElementById("patients").innerHTML =
            "<p>Unable to connect with server.</p>";

    }

}


document
    .getElementById("loadPatients")
    .addEventListener("click", loadPatients);


loadPatients();
