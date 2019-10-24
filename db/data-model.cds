namespace sap.roadmap;
using { managed } from '@sap/cds/common';

entity Roadmap : managed {
	key id: UUID @(title: '{i18n>key}', Common.Label: '{i18n>key}');
	title:   String @(title: '{i18n>title}', Common.FieldControl: #Mandatory, Search.defaultSearchElement, Common.Label: '{i18n>title}');
	date: String(10) @(title: '{i18n>date}', Common.FieldControl: #Mandatory, Search.defaultSearchElement, Common.Label: '{i18n>date}', Common.IsCalendarYearMonth);
	description:  String(200) @(title: '{i18n>description}', Common.FieldControl: #Mandatory, Search.defaultSearchElement, Common.Label: '{i18n>description}');
	likes: Integer @(title: '{i18n>likes}', Common.Label: '{i18n>likes}');
	chips: Composition of many Chip on chips.owner = $self @(title: '{i18n>chips}', Common.Label: '{i18n>chips}');
	tags: Composition of many Tag on tags.owner = $self @(title: '{i18n>tags}', Common.Label: '{i18n>tags}');
	bookmark: Boolean default false @(title: '{i18n>bookmark}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>title}');
	businessvalues: LargeString @(title: '{i18n>businessvalues}',  Search.defaultSearchElement, Common.Label: '{i18n>businessvalues}', UI.MultiLineText: true);
	featuredetails: LargeString @(title: '{i18n>featuredetails}',  Search.defaultSearchElement, Common.Label: '{i18n>featuredetails}', UI.MultiLineText: true);
	crossqualities: LargeString @(title: '{i18n>crossqualities}',  Search.defaultSearchElement, Common.Label: '{i18n>crossqualities}', UI.MultiLineText: true);
	highlight_in_aggregate: Boolean default false @(title: '{i18n>hightlight}', Common.Label: '{i18n>highlight}');
	futureplans: Composition of many FuturePlan on futureplans.owner = $self @(title: '{i18n>futureplans}', Common.Label: '{i18n>futureplans}');
	attachments: Composition of many Attachment on attachments.owner = $self @(title: '{i18n>attachment}', Common.Label: '{i18n>attachment}');
	products: Composition of many Products on products.owner = $self  @(title: '{i18n>product}', Common.Label: '{i18n>product}');
	subProducts: Composition of many SubProducts on subProducts.owner = $self  @(title: '{i18n>subProduct}', Common.Label: '{i18n>subProduct}');
	toIntegration: Association to Integration on toIntegration.lkey = $self.integration;
	integration: String @(
	            title: '{i18n>integration}',
            	Common: {
					Label: '{i18n>integration}',
					ValueList: {entity: 'Integration', type: #fixed}
				}
			);
			
    toProcess: Association to Process on toProcess.lkey = $self.process;	
	process: String @(
	            title: '{i18n>process}',
            	Common: {
					Label: '{i18n>process}',
					ValueList: {entity: 'Process', type: #fixed}
				}
			); 
    toSubProcess: Association to SubProcess on toSubProcess.lkey = $self.subProcess;	
	subProcess: String @(
	            title: '{i18n>subprocess}',
            	Common: {
					Label: '{i18n>subprocess}',
					ValueList: {entity: 'SubProcess', type: #fixed}
				}
			);  
			
	toIndustry: Association to Industry on toIndustry.lkey = $self.industry;
	industry: String @(
	            title: '{i18n>industry}',
            	Common: {
					Label: '{i18n>industry}',
					ValueList: {entity: 'Industry', type: #fixed}
				}
			);			
}

entity Integration @(cds.autoexpose, UI.Identification: [ { $Type: 'UI.DataField', Value: label } ]) {
	key lkey: String @(title: '{i18n>lkey}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>lkey}');
	    label: String @(Core.Immutable, UI.HiddenFilter, title: 'Integration Desc', Common.FieldControl: #Mandatory, Common.Label: 'Integration Desc');
}

entity Process @(cds.autoexpose, UI.Identification: [ { $Type: 'UI.DataField', Value: label } ]) {
	key lkey: String @(title: '{i18n>lkey}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>lkey}');
	    label: String @(Core.Immutable, UI.HiddenFilter, title: '{i18n>process}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>process}');
}

entity SubProcess @(cds.autoexpose, UI.Identification: [ { $Type: 'UI.DataField', Value: label } ]) {
    key process: Association to Process;
	key lkey: String @(title: '{i18n>lkey}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>lkey}');
	    label: String @(Core.Immutable, UI.HiddenFilter, title: '{i18n>subprocess}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>subprocess}');
}

entity Product @(cds.autoexpose, UI.Identification: [ { $Type: 'UI.DataField', Value: label } ]) {
	key lkey: String @(title: '{i18n>lkey}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>lkey}');
	    label: String @(Core.Immutable, UI.HiddenFilter, title: '{i18n>product}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>product}');
}

entity SubProduct @(cds.autoexpose, UI.Identification: [ { $Type: 'UI.DataField', Value: label } ]) {
    key product: Association to Product;
	key lkey: String @(title: '{i18n>lkey}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>lkey}');
	    label: String @(Core.Immutable, UI.HiddenFilter, title: '{i18n>subproduct}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>subproduct}');
}

entity Industry @(cds.autoexpose, UI.Identification: [ { $Type: 'UI.DataField', Value: label } ]) {
	key lkey: String @(title: '{i18n>lkey}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>lkey}');
	    label: String @(Core.Immutable, UI.HiddenFilter, title: '{i18n>industry}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>industry}');
}

entity Products {
	key owner: Association to Roadmap;
	toProduct: Association to Product on toProduct.lkey = $self.product;	
	key product: String @(
	            title: '{i18n>product}',
            	Common: {
					Label: '{i18n>product}',
					ValueList: {entity: 'Product', type: #fixed}
				}
			);  
	
}

entity SubProducts {
	key owner: Association to Roadmap;
	toSubProduct: Association to SubProduct on toSubProduct.lkey = $self.subproduct;	
	key subproduct: String @(
	            title: '{i18n>subproduct}',
            	Common: {
					Label: '{i18n>subproduct}',
					ValueList: {entity: 'SubProduct', type: #fixed}
				}
			); 	
}
entity Chip {
   key owner: Association to Roadmap;
   key lkey: String @(title: '{i18n>lkey}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>lkey}');
   label: String @(title: '{i18n>label}', Common.FieldControl: #Mandatory, Common.Label:  '{i18n>label}');
   category: String @(title: '{i18n>category}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>category}');
   parentkey: String @(title: '{i18n>parent_key}',  Common.Label: '{i18n>parent_key}');
}

entity Tag {
    key owner: Association to Roadmap;
	key tag: String @(title: '{i18n>tag}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>tag}');
}

entity Attachment {
    key owner: Association to Roadmap;
	key url: String @(title: '{i18n>attachment}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>attachment}');
}

entity FuturePlan {
    key owner: Association to Roadmap;
    key date: String(10) @(title: '{i18n>date}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>date}');
    detail: LargeString @(title: '{i18n>detail}', Common.FieldControl: #Mandatory, Common.Label: '{i18n>detail}', UI.MultiLineText: true);
}
