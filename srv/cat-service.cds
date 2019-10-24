using { sap.roadmap, sap.common } from '../db/data-model';

service RoadmapService {
  
  
	@Capabilities.InsertRestrictions.Insertable: true
	@Capabilities.UpdateRestrictions.Updatable: true
	@Capabilities.DeleteRestrictions.Deletable: true
	entity Roadmap as projection on roadmap.Roadmap;
	
	@Capabilities.InsertRestrictions.Insertable: true
	@Capabilities.UpdateRestrictions.Updatable: true
	@Capabilities.DeleteRestrictions.Deletable: true
	entity FuturePlan as projection on roadmap.FuturePlan;
}