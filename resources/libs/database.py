### Importando criptografia de senha ###
import bcrypt

### Importando objeto keyword ###
from robot.api.deco import keyword

### Configuração de conexão com o BD ###
from pymongo import MongoClient
client = MongoClient('mongodb+srv://qa:xpirience@cluster0.dqm9l7w.mongodb.net/?retryWrites=true&w=majority')
db = client['markdb']

@keyword('Clean User from database')
def clean_user(user_email):
    users = db['users']
    tasks = db['tasks']

    u = users.find_one({'email': user_email})

    if (u):
        tasks.delete_many({'user': u['_id']})
        tasks.delete_many({'email':  user_email})

### Metodo para delete de usuário ###
@keyword('Remove User from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

### Metodo para inserir usuário ###
@keyword('Insert User from database')
def insert_user(user):

    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))

    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass
    }

    users = db['users']
    users.insert_one(doc)
    print (user)
    