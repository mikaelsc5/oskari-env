-- Layer Group;
INSERT INTO oskari_layergroup (locale) values ('{ fi:{name:"Demo karttatasoja"},sv:{name:"Demo kartor"},en:{name:"Demo layers"}}');

-- Map Layers;
-- base layer;
INSERT INTO oskari_maplayer(type, base_map, groupId, name, url, locale)
  VALUES('collection', true, (SELECT MAX(id) FROM oskari_layergroup), '1_group', 'collection',
         '{ fi:{name:"local GeoServer WMS",subtitle:""},sv:{name:"local GeoServer WMS",subtitle:""},en:{name:"local GeoServer WMS",subtitle:""}}');

-- link to inspire theme;
INSERT INTO oskari_maplayer_themes(maplayerid,
                                   themeid)
  VALUES((SELECT id FROM oskari_maplayer WHERE name = '1_group'),
         (SELECT id FROM portti_inspiretheme WHERE locale LIKE '%Others%'));

-- sublayers;

INSERT INTO oskari_maplayer(parentId, type, name,
                            minscale, maxscale,
                            url,
                            locale)
  VALUES((SELECT id FROM oskari_maplayer WHERE name = '1_group'), 'wmslayer', 'oskari:8000000',
         15000000,2834657,
         'http://localhost:8080/geoserver/oskari/wms',
         '{ fi:{name:"Geoserver Taustakartta",subtitle:""},sv:{name:"GeoServer Bakgrundskarta",subtitle:""},en:{name:"GeoServer Background map",subtitle:""}}');


INSERT INTO oskari_maplayer(parentId, type, name,
                            minscale, maxscale, metadataId,
                            url,
                            locale)
  VALUES((SELECT id FROM oskari_maplayer WHERE name = '1_group'), 'wmslayer', 'oskari:4000000',
         2834657,1417333,'c22da116-5095-4878-bb04-dd7db3a1a341',
         'http://localhost:8080/geoserver/oskari/wms',
         '{ fi:{name:"Taustakartta 1:4milj",subtitle:""},sv:{name:"Bakgrundskarta 1:4milj",subtitle:""},en:{name:"Background map 1:4mill",subtitle:""}}');


INSERT INTO oskari_maplayer(parentId, type, name,
                            minscale, maxscale, metadataId,
                            url,
                            locale)
  VALUES((SELECT id FROM oskari_maplayer WHERE name = '1_group'), 'wmslayer', 'oskari:2000000',
         1417333,566939,'c22da116-5095-4878-bb04-dd7db3a1a341',
         'http://localhost:8080/geoserver/oskari/wms',
         '{ fi:{name:"Taustakartta 1:2milj",subtitle:""},sv:{name:"Bakgrundskarta 1:2milj",subtitle:""},en:{name:"Background map 1:2mill",subtitle:""}}');

INSERT INTO oskari_maplayer(parentId, type, name,
                            minscale, maxscale, metadataId,
                            url,
                            locale)
  VALUES((SELECT id FROM oskari_maplayer WHERE name = '1_group'), 'wmslayer', 'oskari:800000',
         566939,283474,'c22da116-5095-4878-bb04-dd7db3a1a341',
         'http://localhost:8080/geoserver/oskari/wms',
         '{ fi:{name:"Taustakartta 1:800k",subtitle:""},sv:{name:"Bakgrundskarta 1:800k",subtitle:""},en:{name:"Background map 1:800k",subtitle:""}}');

-- permissions;
-- baselayer: adding permissions to roles with id 10110, 2, and 3;
INSERT INTO oskari_resource(resource_type, resource_mapping) values ('maplayer', 'collection+1_group');

-- give view_layer permission for the resource to ROLE 10110 (guest);
INSERT INTO oskari_permission(oskari_resource_id, external_type, permission, external_id) values
((SELECT id FROM oskari_resource WHERE resource_type = 'maplayer' AND resource_mapping = 'collection+1_group'), 'ROLE', 'VIEW_LAYER', '10110');

-- give view_layer permission for the resource to ROLE 2 (user);
INSERT INTO oskari_permission(oskari_resource_id, external_type, permission, external_id) values
((SELECT id FROM oskari_resource WHERE resource_type = 'maplayer' AND resource_mapping = 'collection+1_group'), 'ROLE', 'VIEW_LAYER', '2');

-- give view_layer permission for the resource to ROLE 3 (admin);
INSERT INTO oskari_permission(oskari_resource_id, external_type, permission, external_id) values
((SELECT id FROM oskari_resource WHERE resource_type = 'maplayer' AND resource_mapping = 'collection+1_group'), 'ROLE', 'VIEW_LAYER', '3');

-- give publish permission for the resource to ROLE 2 (user);
INSERT INTO oskari_permission(oskari_resource_id, external_type, permission, external_id) values
((SELECT id FROM oskari_resource WHERE resource_type = 'maplayer' AND resource_mapping = 'collection+1_group'), 'ROLE', 'PUBLISH', '2');

-- give publish permission for the resource to ROLE 3 (admin);
INSERT INTO oskari_permission(oskari_resource_id, external_type, permission, external_id) values
((SELECT id FROM oskari_resource WHERE resource_type = 'maplayer' AND resource_mapping = 'collection+1_group'), 'ROLE', 'PUBLISH', '3');

-- give view_published_layer permission for the resource to ROLE 10110 (guest);
INSERT INTO oskari_permission(oskari_resource_id, external_type, permission, external_id) values
((SELECT id FROM oskari_resource WHERE resource_type = 'maplayer' AND resource_mapping = 'collection+1_group'), 'ROLE', 'VIEW_PUBLISHED', '10110');

-- give view_published_layer permission for the resource to ROLE 2 (user);
INSERT INTO oskari_permission(oskari_resource_id, external_type, permission, external_id) values
((SELECT id FROM oskari_resource WHERE resource_type = 'maplayer' AND resource_mapping = 'collection+1_group'), 'ROLE', 'VIEW_PUBLISHED', '2');

-- give view_published_layer permission for the resource to ROLE 3 (admin);
INSERT INTO oskari_permission(oskari_resource_id, external_type, permission, external_id) values
((SELECT id FROM oskari_resource WHERE resource_type = 'maplayer' AND resource_mapping = 'collection+1_group'), 'ROLE', 'VIEW_PUBLISHED', '3');

-- wmslayer: add layer as resource for mapping permissions;
INSERT INTO oskari_resource(resource_type, resource_mapping) values ('maplayer', 'http://localhost:8080/geoserver/oskari/wms+WMS');
