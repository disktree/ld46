// Auto-generated
package ;
class Main {
    public static inline var projectName = 'ld46';
    public static inline var projectPackage = 'ld46';
    public static inline var voxelgiVoxelSize = 16.0 / 64;
    public static inline var voxelgiHalfExtents = 8;
    public static function main() {
        iron.object.BoneAnimation.skinMaxBones = 8;
        iron.object.LightObject.cascadeCount = 2;
        iron.object.LightObject.cascadeSplitFactor = 0.800000011920929;
        armory.system.Starter.main(
            'Boot',
            0,
            false,
            true,
            false,
            1920,
            1080,
            1,
            true,
            armory.renderpath.RenderPathCreator.get
        );
    }
}
