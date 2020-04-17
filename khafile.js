// Auto-generated
let project = new Project('ld46');

project.addSources('Sources');
project.addShaders('build_ld46/compiled/Shaders/Project/**');
project.addLibrary("/home/tong/sdk/ArmorySDK/armory");
project.addLibrary("/home/tong/sdk/ArmorySDK/iron");
project.addLibrary("/home/tong/sdk/ArmorySDK/lib/haxebullet");
project.addAssets("/home/tong/sdk/ArmorySDK/lib/haxebullet/ammo/ammo.wasm.js", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/lib/haxebullet/ammo/ammo.wasm.wasm", { notinlist: true });
project.addParameter('armory.trait.physics.bullet.PhysicsWorld');
project.addParameter("--macro keep('armory.trait.physics.bullet.PhysicsWorld')");
project.addParameter('ld46.scene.Game');
project.addParameter("--macro keep('ld46.scene.Game')");
project.addParameter('ld46.scene.Boot');
project.addParameter("--macro keep('ld46.scene.Boot')");
project.addParameter('armory.trait.physics.bullet.RigidBody');
project.addParameter("--macro keep('armory.trait.physics.bullet.RigidBody')");
project.addParameter('armory.trait.WalkNavigation');
project.addParameter("--macro keep('armory.trait.WalkNavigation')");
project.addParameter('ld46.scene.Mainmenu');
project.addParameter("--macro keep('ld46.scene.Mainmenu')");
project.addShaders("build_ld46/compiled/Shaders/*.glsl", { noembed: false});
project.addAssets("build_ld46/compiled/Assets/**", { notinlist: true });
project.addAssets("build_ld46/compiled/Shaders/*.arm", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/brdf.png", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/smaa_area.png", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/smaa_search.png", { notinlist: true });
project.addAssets("Bundled/canvas/MainmenuCanvas.files", { notinlist: true });
project.addAssets("Bundled/canvas/MainmenuCanvas.json", { notinlist: true });
project.addAssets("Bundled/canvas/_themes.json", { notinlist: true });
project.addAssets("Bundled/font/BDGem.ttf", { notinlist: false });
project.addAssets("Bundled/font/helvetica_neue_75.ttf", { notinlist: false });
project.addAssets("Bundled/index.html", { notinlist: true });
project.addAssets("Bundled/sound/Bass-Deep 05.wav", { notinlist: true , quality: 0.8999999761581421});
project.addAssets("Bundled/sound/Machine-QuiteRumble.wav", { notinlist: true , quality: 0.8999999761581421});
project.addAssets("Bundled/sound/boot.wav", { notinlist: true , quality: 0.8999999761581421});
project.addAssets("Bundled/sound/rumble_underground.wav", { notinlist: true , quality: 0.8999999761581421});
project.addLibrary("/home/tong/sdk/ArmorySDK/lib/zui");
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/font_default.ttf", { notinlist: false });
project.addDefine('arm_deferred');
project.addDefine('arm_csm');
project.addDefine('rp_hdr');
project.addDefine('rp_renderer=Deferred');
project.addDefine('rp_shadowmap');
project.addDefine('rp_shadowmap_cascade=1024');
project.addDefine('rp_shadowmap_cube=512');
project.addDefine('rp_background=World');
project.addDefine('rp_render_to_texture');
project.addDefine('rp_compositornodes');
project.addDefine('rp_antialiasing=SMAA');
project.addDefine('rp_supersampling=1');
project.addDefine('rp_ssgi=SSAO');
project.addDefine('arm_audio');
project.addDefine('arm_physics');
project.addDefine('arm_bullet');
project.addDefine('arm_noembed');
project.addDefine('arm_soundcompress');
project.addDefine('arm_ui');
project.addDefine('arm_skin');
project.addDefine('arm_particles');

///// LD46 - DEV ------------------

project.addDefine('dev');


resolve(project);
