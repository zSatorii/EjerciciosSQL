show dbs
db
help
use CursosJohanCastro

use CursosJohanCastro
db
show dbs

db.alumnoJohanCastro.insert({
nombre: "Juan Pérez",
edad: 22,
carrera: "Estadística"
})

use BaseDatosJohanCastro

db.dropDatabase()

show dbs

db.createCollection("cursosJohanCastro")

show collections

db.cursosJohanCastro.drop()

db.alumnoJohanCastro.find()

db.alumnoJohanCastro.find().pretty()

db.alumnoJohanCastro.find().pretty()

db.cursoJohanCastro.insert([
{
nombre: "Probabilidad II",
creditos: 10,
horas: { teoria: 6, practica: 4 }
},
{
nombre: "Estadística Inferencial",
creditos: 8,
horas: { teoria: 5, practica: 3 }
},
{
nombre: "Bases de Datos",
creditos: 12,
horas: { teoria: 4, practica: 8 }
}
])


db.cursoJohanCastro.find({nombre: "Probabilidad II"})

db.cursoJohanCastro.find({
creditos: 10,
nombre: "Probabilidad II"
})

db.cursoJohanCastro.find({"horas.practica": 4})

db.cursoJohanCastro.find({
"horas.practica": 4,
creditos: 10
})

db.cursoJohanCastro.findOne({
"horas.practica": 4
})

db.cursoJohanCastro.find(
{},
{
nombre: 1,
creditos: 1,
_id: 0
}
)


db.cursoJohanCastro.find().sort({nombre: 1}).pretty()

db.cursoJohanCastro.find().sort({creditos: 1})

db.cursoJohanCastro.find().sort({creditos: -1})

db.cursoJohanCastro.find().sort({
creditos: -1,
nombre: 1
})


db.cursoJohanCastro.find().limit(2)

db.cursoJohanCastro.find()
.sort({creditos: -1})
.limit(5)

db.cursoJohanCastro.count()

db.cursoJohanCastro.count({
creditos: {$gt: 8}
})

for(var i = 1; i <= 10; i++) {
db.estudiantesJohanCastro.insert({
nombre: "Estudiante " + i,
codigo: 1000 + i,
promedio: Math.random() * 5
})
}

function buscarPorCreditosJohanCastro(min, max) {
return db.cursoJohanCastro.find({
creditos: {$gte: min, $lte: max}
}).toArray()
}

db.coleccionJohanCastro.update(
{criterios_de_seleccion},
{operacion_de_actualizacion},
{opciones}
)


db.cursoJohanCastro.update(
{nombre: "Probabilidad II"},
{$set: {
departamento: "Estadística",
semestre: 4,
activo: true
}}
)


db.cursoJohanCastro.update(
{nombre: "Bases de Datos"},
{$set: {
creditos: 15
}}
)

db.cursoJohanCastro.update(
{nombre: "Bases de Datos"},
{$set: {
creditos: 15,
"horas.teoria": 5,
"horas.practica": 10,
actualizado: new Date()
}}
)

db.cursoJohanCastro.update(
{nombre: "Probabilidad II"},
{$inc: {creditos: 2}}
)

db.estudianteJohanCastro.update(
{codigo: 1001},
{$mul: {beca: 1.1}}
)

db.estudianteJohanCastro.update(
{codigo: 1001},
{$max: {notaMaxima: 4.5}}
)


db.cursoJohanCastro.update(
{nombre: "Probabilidad II"},
{$rename: {
"creditos": "numeroCreditos"
}}
)

db.cursoJohanCastro.update(
{},
{$rename: {
"creditos": "numeroCreditos",
"horas": "horasSemanales"
}},
{multi: true}
)


db.cursoJohanCastro.update(
{nombre: "Probabilidad II"},
{$unset: {
departamento: ""
}}
)

db.cursoJohanCastro.remove({
nombre: "Bases de Datos"
})

db.cursoJohanCastro.removeOne({
creditos: 10
})

db.cursoJohanCastro.remove({})


db.cursoJohanCastro.find({
creditos: {$gte: 10}
})

db.cursoJohanCastro.find({
creditos: {$lte: 8}
})

db.cursoJohanCastro.find({
nombre: {$ne: "Probabilidad II"}
})

db.cursoJohanCastro.find({
creditos: {$in: [8, 10, 12]}
})

db.cursoJohanCastro.find({
$and: [
{creditos: {$gte: 10}},
{"horas.practica": {$gte: 4}}
]
})

db.cursoJohanCastro.find({
$or: [
{creditos: 10},
{creditos: 12}
]
})

db.cursoJohanCastro.find({
creditos: {
$not: {$lte: 8}
}
})

db.cursoJohanCastro.find({
temas: "Probabilidad"
})

db.cursoJohanCastro.find({
temas: {
$all: ["Probabilidad", "Estadística"]
}
})

db.cursoJohanCastro.find({
temas: {$size: 5}
})

db.estudiantesJohanCastro.find({
notas: {
$elemMatch: {
$gte: 4.0,
$lte: 5.0
}
}
})

db.cursoJohanCastro.update(
{nombre: "Probabilidad II"},
{$push: {
temas: "Distribuciones"
}}
)

db.cursoJohanCastro.update(
{nombre: "Probabilidad II"},
{$pull: {
temas: "Distribuciones"
}}
)

db.cursoJohanCastro.update(
{nombre: "Probabilidad II"},
{$addToSet: {temas: "Probabilidad"}}
)

db.cursoJohanCastro.update(
{nombre: "Probabilidad II"},
{$pop: {temas: 1}}
)

db.cursoJohanCastro.createIndex({nombre: 1})

db.cursoJohanCastro.createIndex({
creditos: 1,
nombre: 1
})

db.cursoJohanCastro.getIndexes()


db.cursoJohanCastro.createIndex({
descripcion: "text",
nombre: "text"
})

db.cursoJohanCastro.find({
$text: {
$search: "probabilidad estadística"
}
})

db.cursoJohanCastro.find({
$text: {
$search: "\"probabilidad condicional\""
}
})


db.cursoJohanCastro.aggregate([
{$match: {creditos: {$gte: 10}}},
{$group: {_id: "$departamento", total: {$sum: "$creditos"}}},
{$sort: {total: -1}}
])


db.cursoJohanCastro.createIndex({nombre: 1})

db.cursoJohanCastro.createIndex({creditos: -1})

db.cursoJohanCastro.getIndexes()

db.empleadosJohanCastro.insert({
nombre: "Johan Castro",
apellido: "Pérez",
email: "johan.castro@example.com",
departamento: "Desarrollo",
salario: 3500000,
fechaIngreso: new Date("2020-01-15"),
activo: true,
certificaciones: ["MongoDB", "JavaScript", "Node.js"]
})

db.empleadosJohanCastro.find()

db.empleadosJohanCastro.findOne({nombre: "Johan Castro"})

db.empleadosJohanCastro.update(
{nombre: "Johan Castro"},
{$set: {
salario: 4000000,
certificaciones: ["MongoDB", "JavaScript", "Node.js", "React"]
}}
)

db.empleadosJohanCastro.count()

db.empleadosJohanCastro.update(
{nombre: "Johan Castro"},
{$push: {
certificaciones: "Python"
}}
)

db.empleadosJohanCastro.find().sort({salario: -1})

db.empleadosJohanCastro.find(
{},
{nombre: 1, email: 1, _id: 0}
)

db.empleadosJohanCastro.find({
salario: {$gte: 3500000}
})

db.empleadosJohanCastro.find({
$and: [
{departamento: "Desarrollo"},
{salario: {$gte: 3000000}}
]
})

db.empleadosJohanCastro.update(
{nombre: "Johan Castro"},
{$pull: {
certificaciones: "JavaScript"
}}
)

db.empleadosJohanCastro.createIndex({nombre: 1})

db.empleadosJohanCastro.createIndex({
departamento: 1,
salario: -1
})

db.empleadosJohanCastro.createIndex({
certificaciones: "text",
departamento: "text"
})

db.empleadosJohanCastro.find({
$text: {
$search: "MongoDB"
}
})

db.empleadosJohanCastro.aggregate([
{$group: {
_id: "$departamento",
totalEmpleados: {$sum: 1},
salarioPromedio: {$avg: "$salario"}
}},
{$sort: {totalEmpleados: -1}}
])

db.empleadosJohanCastro.find({
certificaciones: {$size: 4}
})


db.empleadosJohanCastro.find({
salario: {
$gte: 3000000,
$lte: 5000000
}
})

db.empleadosJohanCastro.update(
{nombre: "Johan Castro"},
{$set: {
certificaciones: ["MongoDB Professional", "Node.js Expert", "Full Stack Developer"]
}}
)

db.empleadosJohanCastro.remove({
nombre: "Johan Castro"
})

db.createCollection("empleadosJohanCastro", {
validator: {
$jsonSchema: {
bsonType: "object",
required: ["nombre", "email", "departamento"],
properties: {
nombre: {bsonType: "string"},
email: {bsonType: "string"},
departamento: {bsonType: "string"},
salario: {bsonType: "number"},
certificaciones: {bsonType: "array"}
}
}
}
})

