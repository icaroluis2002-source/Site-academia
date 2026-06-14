const API_URL = "https://site-academia-d1fc.onrender.com";

// ===== LOGIN =====

const loginForm = document.getElementById("loginForm");

if (loginForm) {
    loginForm.addEventListener("submit", async function (event) {
        event.preventDefault();

        const email = document.getElementById("email").value;
        const senha = document.getElementById("senha").value;

        try {
            const resposta = await fetch(`${API_URL}/login`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    email,
                    senha
                })
            });

            const dados = await resposta.json();

            if (dados.sucesso) {
                localStorage.setItem(
                    "id_usuario",
                    dados.id_usuario
                );

                localStorage.setItem(
                    "nomeUsuario",
                    dados.nome
                );

                window.location.href = "dashboard.html";
            } else {
                alert("Email ou senha inválidos");
            }

        } catch (erro) {
            console.error("Erro:", erro);
            alert("Não foi possível conectar ao servidor.");
        }
    });
}

// ===== PERFIL =====

const perfilForm = document.getElementById("perfilForm");

if (perfilForm) {
    perfilForm.addEventListener("submit", function (event) {
        event.preventDefault();
        alert("Dados atualizados com sucesso!");
    });
}

async function carregarPerfil() {
    try {
        const idUsuario =
            localStorage.getItem("id_usuario");

        if (!idUsuario) {
            console.log("Usuário não logado.");
            return;
        }

        const resposta = await fetch(
            `${API_URL}/perfil/${idUsuario}`
        );

        const usuario = await resposta.json();

        document.getElementById("nome").value =
            usuario.nome || "";

        document.getElementById("email").value =
            usuario.email || "";

        const telefone =
            document.getElementById("telefone");

        if (telefone) {
            telefone.value =
                usuario.telefone || "";
        }

    } catch (erro) {
        console.error(
            "Erro ao carregar perfil:",
            erro
        );
    }
}

if (document.getElementById("perfilForm")) {
    carregarPerfil();
}