const xsenv = require("@sap/xsenv")
xsenv.loadEnv()
	//const HDBConn = require("@sap/hdbext")
let hanaOptions = xsenv.getServices({
	hana: {
		tag: "hana"
	}
})
hanaOptions.hana.pooling = true
const fs = require("fs");
let importData = fs.readFileSync(__dirname + "/roadmapJson.json", "utf8");
let roadmapData = JSON.parse(importData)

async function cdsStuff(roadmapData) {
	const cds = require("@sap/cds")
		//CDS OData V4 Handler
	let cdsOptions = {
		kind: "hana",
		model: __dirname + "/gen/csn.json",
		logLevel: "error"
	};
	const db = await cds.connect(cdsOptions)
	const {
		Roadmap,
		FuturePlan
	} = db.entities('sap.roadmap')

	for (let item of roadmapData) {
		let roadmapInsertItem = {}
		let futurePlanItem = {}
		let futurePlanKeys = Object.keys(item).filter(v => v.match(/FuturePlan.._Date/))
		const uuidv4 = require('uuid/v4')
		roadmapInsertItem.id = uuidv4() // item._id.$oid
		roadmapInsertItem.title = item.Title
		console.log(roadmapInsertItem)
		try {
			await db.run(INSERT.into(Roadmap).entries(roadmapInsertItem))
		} catch (err) {
			console.error(err)
		}

		for (const[i, key] of futurePlanKeys.entries()) {
			futurePlanItem.owner_id = roadmapInsertItem.id
			futurePlanItem.date = item[key] + i
			futurePlanItem.detail = item[key.replace("_Date", "_details")]

			try {
				await db.run(INSERT.into(FuturePlan).entries(futurePlanItem))
			} catch (err) {
				console.error(err)
			}
		}
		/*	await db.run(INSERT.into(Roadmap).entries({
				_id: uuidv4(),
				title: 'My Test',
				date: '2019-08',
				description: 'Test Description',
				texts: [{title: 'My Test', locale: 'en' }],
				chips: [{lkey:"salescloud"}]
			}))*/
	}
}

cdsStuff(roadmapData)